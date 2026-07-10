import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/post_model.dart';
import '../data/dummy_posts.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';

class HomeController extends GetxController {
  var posts = <PostModel>[].obs;
  var currentIndex = 0.obs;
  var isDarkMode = false.obs;
  
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;
  bool _hasAdBeenShown = false;

  final AudioPlayer _audioPlayer = AudioPlayer();
  var isPlaying = false.obs;

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    loadPosts();
    _loadInterstitialAd();
    _setupAudio();
  }

  void scrollToPost(int index) {
    currentIndex.value = index;
    // We use a slight delay to ensure the PageView is built
    Future.delayed(const Duration(milliseconds: 100), () {
      if (pageController.hasClients) {
        pageController.jumpToPage(index);
      }
    });
  }

  void _setupAudio() {
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });
  }

  void loadPosts() {
    posts.assignAll(DummyData.posts);
    if (posts.isNotEmpty) {
      _playAudioForIndex(0);
    }
  }

  void _playAudioForIndex(int index) async {
    if (posts.isEmpty || index >= posts.length) return;
    String? url = posts[index].audioUrl;
    if (url != null) {
      try {
        await _audioPlayer.play(UrlSource(url));
      } catch (e) {
        debugPrint("Audio play error: $e");
      }
    } else {
      await _audioPlayer.stop();
    }
  }

  void updateCaption(String id, String newCaption) {
    int index = posts.indexWhere((p) => p.id == id);
    if (index != -1) {
      posts[index] = posts[index].copyWith(caption: newCaption);
    }
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleAudio() {
    if (isPlaying.value) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.resume();
    }
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
    _playAudioForIndex(index);
    
    // TRIGGER: Landed on 3rd reel
    if (index == 2 && !_hasAdBeenShown) {
      if (_isAdLoaded) {
        _showInterstitialAd();
        _hasAdBeenShown = true;
      } else {
        // Fallback: load and show if it becomes ready while on this page
        _loadInterstitialAd(showAfterLoad: true);
      }
    }
  }

  void _loadInterstitialAd({bool showAfterLoad = false}) {
    final adUnitId = Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/1033173712'
        : 'ca-app-pub-3940256099942544/4411468910';

    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;
          
          if (showAfterLoad && currentIndex.value == 2 && !_hasAdBeenShown) {
            _showInterstitialAd();
            _hasAdBeenShown = true;
          }

          _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _isAdLoaded = false;
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _isAdLoaded = false;
            },
          );
        },
        onAdFailedToLoad: (err) {
          debugPrint('InterstitialAd failed to load: $err');
          _isAdLoaded = false;
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_isAdLoaded && _interstitialAd != null) {
      _interstitialAd!.show();
    }
  }

  void sharePost(PostModel post, String platform) {
    Get.dialog(
      _ShareLoadingDialog(platform: platform),
      barrierDismissible: false,
    );

    Future.delayed(const Duration(seconds: 4), () {
      Get.back();
      Get.snackbar(
        "Shared",
        "Successfully shared to $platform",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.accent,
        colorText: AppColors.black,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.check_circle, color: AppColors.black),
      );
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    _audioPlayer.dispose();
    _interstitialAd?.dispose();
    super.onClose();
  }
}

class _ShareLoadingDialog extends StatefulWidget {
  final String platform;
  const _ShareLoadingDialog({required this.platform});

  @override
  State<_ShareLoadingDialog> createState() => _ShareLoadingDialogState();
}

class _ShareLoadingDialogState extends State<_ShareLoadingDialog> {
  double _progress = 0.0;
  String _status = "Generating your unique link...";

  @override
  void initState() {
    super.initState();
    _simulateProgress();
  }

  void _simulateProgress() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() { _progress = 0.3; _status = "Copying the caption to clipboard"; });
    
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() { _progress = 0.6; _status = "Saving the content to your profile"; });

    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() { _progress = 0.9; _status = "Preparing the content for ${widget.platform}"; });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusM)),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    value: _progress,
                    strokeWidth: 6,
                    backgroundColor: AppColors.lightGrey,
                    valueColor: const AlwaysStoppedAnimation(AppColors.accent),
                  ),
                ),
                Icon(
                  _progress > 0.8 ? Icons.check : Icons.link,
                  color: AppColors.accent,
                ),
              ],
            ),
            const SizedBox(height: AppSizes.l),
            Text(
              _status,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: AppSizes.m),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: _progress,
                minHeight: 8,
                backgroundColor: AppColors.lightGrey,
                valueColor: const AlwaysStoppedAnimation(AppColors.accent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

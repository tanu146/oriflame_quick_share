import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/post_model.dart';
import '../controllers/home_controller.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';

class EditCaptionScreen extends StatefulWidget {
  const EditCaptionScreen({super.key});

  @override
  State<EditCaptionScreen> createState() => _EditCaptionScreenState();
}

class _EditCaptionScreenState extends State<EditCaptionScreen> {
  late PostModel post;
  late TextEditingController _controller;
  final RxBool _hasChanges = false.obs;
  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    post = Get.arguments as PostModel;
    _controller = TextEditingController(text: post.caption);
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    _hasChanges.value = _controller.text != post.caption;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkBackground : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: isDark ? Colors.white : AppColors.black),
          onPressed: () {
            homeController.startAudio(); // Resume audio
            Get.back();
          },
        ),
        title: Text(
          "Edit Caption",
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.black, 
            fontWeight: FontWeight.bold, 
            fontSize: 18
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ElevatedButton(
              onPressed: _hasChanges.value
                  ? () {
                      homeController.updateCaption(post.id, _controller.text);
                      homeController.startAudio(); // Resume audio
                      Get.back();
                      Get.snackbar(
                        "Success",
                        "Caption updated",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.accent,
                        colorText: AppColors.black,
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                disabledBackgroundColor: AppColors.lightGrey.withOpacity(0.5),
                foregroundColor: AppColors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text("Save", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          )),
        ],
      ),
      body: Column(
        children: [
          Divider(height: 1, color: isDark ? Colors.white10 : Colors.black12),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _controller,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 15, 
                      height: 1.6, 
                      color: isDark ? Colors.white : AppColors.black
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Write your caption here...",
                    ),
                    autofocus: true,
                  ),
                  // const SizedBox(height: 20),
                  // const Text(
                  //   "💧 Keep your lips soft, plump, and perfectly hydrated all day! Our Hyaluronic Lip Balm is infused with moisture-locking ingredients to nourish, smooth, and add a natural, glossy finish. Say goodbye to dryness and hello to a luscious, healthy pout! 💋✨ #HydratedLips #PlumpAndGlow #LipCare",
                  //   style: TextStyle(color: AppColors.grey, fontSize: 13, height: 1.5),
                  // ),
                  const SizedBox(height: 24),
                  _buildReferralDetail("Use my referral link", post.referralLink, isDark),
                  const SizedBox(height: 12),
                  _buildReferralDetail("Use my referral code", post.referralCode, isDark),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralDetail(String label, String value, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label:",
          style: const TextStyle(color: AppColors.grey, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: isDark ? Colors.white70 : AppColors.black, 
            fontSize: 14,
            fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}

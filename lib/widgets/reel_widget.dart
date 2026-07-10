import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/post_model.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/routes/app_routes.dart';
import '../controllers/home_controller.dart';
import 'product_info_card.dart';

class ReelWidget extends StatelessWidget {
  final PostModel post;
  final int index;
  final int total;

  const ReelWidget({
    super.key, 
    required this.post, 
    required this.index, 
    required this.total
  });

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image Logic: Local Asset first, then Network
        post.localAssetName != null 
          ? Image.asset(
              'assets/${post.localAssetName}',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildNetworkImage(),
            )
          : _buildNetworkImage(),
        
        // Gradient Overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.transparent,
                Colors.transparent,
                Colors.black.withOpacity(0.8),
              ],
              stops: const [0.0, 0.2, 0.5, 1.0],
            ),
          ),
        ),

        // Side Indicators
        Positioned(
          right: 16,
          bottom: 250,
          child: Column(
            children: [
              Text("${index + 1} of $total", style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...List.generate(total, (i) => Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == index ? AppColors.accent : Colors.white.withOpacity(0.5),
                ),
              )),
              const SizedBox(height: 20),
              Obx(() => GestureDetector(
                onTap: () => controller.toggleAudio(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Icon(
                    controller.isPlaying.value ? Icons.volume_up : Icons.volume_off,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              )),
            ],
          ),
        ),

        // Content
        Padding(
          padding: const EdgeInsets.all(AppSizes.m),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Info Card (Moved above profile)
              if (post.product != null)
                ProductInfoCard(product: post.product!),

              // Profile Row
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(post.profileImage),
                  ),
                  const SizedBox(width: AppSizes.s),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                             _buildAnimatedBadge(),
                             const SizedBox(width: 8),
                             const Text("Ready to share", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text(
                          post.username,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.m),

              // Music info
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.music_note, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      "RECOMMENDED: ${post.musicName}",
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.m),

              // Caption Area
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome, color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        "AI CAPTION SUGGESTION",
                        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.editCaption, arguments: post),
                    child: const Row(
                      children: [
                        Icon(Icons.edit, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text("Edit Caption", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
                  children: [
                    TextSpan(text: post.caption),
                    const TextSpan(text: " see more", style: TextStyle(color: Colors.white60, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text("Use my referral link: ${post.referralLink}", style: const TextStyle(color: Colors.white70, fontSize: 11)),
              Text("Use my referral code: ${post.referralCode}", style: const TextStyle(color: Colors.white70, fontSize: 11)),
              
              const SizedBox(height: AppSizes.m),

              // Social Icons
              const Text("Quick share to:", style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 8),
              SizedBox(
                height: 44,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildSocialAssetIcon('instagram_logo.png', () => controller.sharePost(post, "Instagram")),
                    _buildSocialAssetIcon('facebook_logo.png', () => controller.sharePost(post, "Facebook")),
                    _buildSocialAssetIcon('messenger_logo.png', () => controller.sharePost(post, "Messenger")),
                    _buildSocialAssetIcon('whatsapp_logo.png', () => controller.sharePost(post, "WhatsApp")),
                    _buildSocialAssetIcon('wp_bus_logo.png', () => controller.sharePost(post, "WhatsApp Business")),
                    _buildSocialAssetIcon('tiktok_logo.png', () => controller.sharePost(post, "TikTok")),
                    _buildSocialAssetIcon('telegram_logo.png', () => controller.sharePost(post, "Telegram")),
                    _buildSocialAssetIcon('mail_logo.png', () => controller.sharePost(post, "Email")),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.s),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNetworkImage() {
    return Image.network(
      post.imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => _buildDefaultPlaceholder(),
    );
  }

  Widget _buildDefaultPlaceholder() {
    return Container(
      color: Colors.grey[900],
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, color: Colors.white24, size: 80),
          SizedBox(height: 16),
          Text("Oriflame Beauty", style: TextStyle(color: Colors.white24, letterSpacing: 4, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAnimatedBadge() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.pink.withOpacity(0.8 * value),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 10),
        );
      },
    );
  }

  Widget _buildSocialAssetIcon(String assetName, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(2),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/$assetName',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.share, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/post_model.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/routes/app_routes.dart';
import '../controllers/home_controller.dart';
import 'product_info_card.dart';

class ReelWidget extends StatefulWidget {
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
  State<ReelWidget> createState() => _ReelWidgetState();
}

class _ReelWidgetState extends State<ReelWidget> {
  bool isCaptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Stack(
      fit: StackFit.expand,
      children: [
        widget.post.localAssetName != null
          ? Image.asset(
              'assets/${widget.post.localAssetName}',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildNetworkImage(),
            )
          : _buildNetworkImage(),
        
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.transparent,
                Colors.transparent,
                Colors.black.withOpacity(0.85),
              ],
              stops: const [0.0, 0.2, 0.5, 1.0],
            ),
          ),
        ),

        Positioned(
          right: AppSizes.m,
          top: 160,
          child: Column(
            children: [
              Text("${widget.index + 1} of ${widget.total}", 
                style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...List.generate(widget.total, (i) => Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == widget.index ? AppColors.accent : Colors.white.withOpacity(0.5),
                ),
              )),
              const SizedBox(height: 24),
              Obx(() => GestureDetector(
                onTap: () => controller.toggleAudio(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: controller.isMuted.value ? Colors.white24 : AppColors.accent.withOpacity(0.5),
                      width: 1.5
                    ),
                  ),
                  child: Icon(
                    controller.isMuted.value ? Icons.volume_off : Icons.volume_up,
                    color: controller.isMuted.value ? Colors.white70 : AppColors.accent,
                    size: 20,
                  ),
                ),
              )),
            ],
          ),
        ),

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.m, vertical: AppSizes.s),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.post.product != null && !isCaptionExpanded)
                  ProductInfoCard(product: widget.post.product!),

                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(widget.post.profileImage),
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
                            widget.post.username,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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

                if (!isCaptionExpanded)
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
                        Flexible(
                          child: Text(
                            "RECOMMENDED: ${widget.post.musicName}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: AppSizes.m),

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
                      onTap: () {
                        controller.stopAudio(); 
                        Get.toNamed(AppRoutes.editCaption, arguments: widget.post);
                      },
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
                
                // Clickable Caption
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCaptionExpanded = !isCaptionExpanded;
                    });
                  },
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          maxLines: isCaptionExpanded ? null : 2,
                          overflow: isCaptionExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                          text: TextSpan(
                            style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
                            children: [
                              TextSpan(text: widget.post.caption),
                              if (!isCaptionExpanded)
                                const TextSpan(text: " see more", style: TextStyle(color: Colors.white60, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        if (isCaptionExpanded) ...[
                          const SizedBox(height: 12),
                          Text("Use my referral link: ${widget.post.referralLink}", 
                            style: const TextStyle(color: Colors.white70, fontSize: 11)),
                          Text("Use my referral code: ${widget.post.referralCode}", 
                            style: const TextStyle(color: Colors.white70, fontSize: 11)),
                          const SizedBox(height: 8),
                          const Text("tap to collapse", style: TextStyle(color: Colors.white30, fontSize: 10, fontStyle: FontStyle.italic)),
                        ]
                      ],
                    ),
                  ),
                ),
                
                if (!isCaptionExpanded) ...[
                  const SizedBox(height: 8),
                  Text("Use my referral link: ${widget.post.referralLink}", 
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70, fontSize: 11)),
                  Text("Use my referral code: ${widget.post.referralCode}", 
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70, fontSize: 11)),
                ],
                
                const SizedBox(height: AppSizes.m),

                // Social Icons
                const Text("Quick share to:", style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 44,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildSocialAssetIcon('instagram_logo.png', () => controller.sharePost(widget.post, "Instagram")),
                      _buildSocialAssetIcon('facebook_logo.png', () => controller.sharePost(widget.post, "Facebook")),
                      _buildSocialAssetIcon('messenger_logo.png', () => controller.sharePost(widget.post, "Messenger")),
                      _buildSocialAssetIcon('whatsapp_logo.png', () => controller.sharePost(widget.post, "WhatsApp")),
                      _buildSocialAssetIcon('wp_bus_logo.png', () => controller.sharePost(widget.post, "WhatsApp Business")),
                      _buildSocialAssetIcon('tiktok_logo.png', () => controller.sharePost(widget.post, "TikTok")),
                      _buildSocialAssetIcon('telegram_logo.png', () => controller.sharePost(widget.post, "Telegram")),
                      _buildSocialAssetIcon('mail_logo.png', () => controller.sharePost(widget.post, "Email")),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNetworkImage() {
    return Image.network(
      widget.post.imageUrl,
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

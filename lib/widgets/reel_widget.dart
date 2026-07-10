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
                Colors.black.withOpacity(0.1),
                Colors.transparent,
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.8),
              ],
              stops: const [0.0, 0.2, 0.7, 1.0],
            ),
          ),
        ),

        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(widget.post.profileImage),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.pink.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.auto_awesome, color: Colors.white, size: 10),
                            SizedBox(width: 4),
                            Text("Ready to share", 
                              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.post.username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "${widget.index + 1} of ${widget.total}",
                style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        Positioned(
          right: 16,
          bottom: 280,
          child: Column(
            children: [
              ...List.generate(widget.total, (i) => Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == widget.index ? AppColors.accent : Colors.white.withOpacity(0.5),
                ),
              )),
              const SizedBox(height: 16),
              Obx(() => GestureDetector(
                onTap: () => controller.toggleAudio(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    controller.isMuted.value ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              )),
            ],
          ),
        ),

        Positioned(
          left: 16,
          right: 16,
          bottom: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.post.product != null)
                ProductInfoCard(product: widget.post.product!),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.music_note, color: Colors.white, size: 14),
                    const SizedBox(width: 8),
                    Text(
                      "RECOMMENDED: ${widget.post.musicName}",
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.auto_awesome_mosaic_outlined, color: Colors.white, size: 16),
                            const SizedBox(width: 6),
                            const Text("CAPTION SUGGESTION", 
                              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.stopAudio();
                            Get.toNamed(AppRoutes.editCaption, arguments: widget.post);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.edit_outlined, color: Colors.white, size: 14),
                              SizedBox(width: 4),
                              Text("Edit Caption", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => setState(() => isCaptionExpanded = !isCaptionExpanded),
                      child: RichText(
                        maxLines: isCaptionExpanded ? null : 2,
                        overflow: isCaptionExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                        text: TextSpan(
                          style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.4),
                          children: [
                            TextSpan(text: widget.post.caption),
                            if (!isCaptionExpanded)
                              const TextSpan(text: " see more", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    if (isCaptionExpanded) ...[
                      const SizedBox(height: 12),
                      Text("Use my referral code: ${widget.post.referralCode}", 
                        style: const TextStyle(color: Colors.white70, fontSize: 11, fontStyle: FontStyle.italic)),
                      Text("Use my referral link: ${widget.post.referralLink}", 
                        style: const TextStyle(color: Colors.white70, fontSize: 11, fontStyle: FontStyle.italic)),
                    ]
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Text("Quick share to:", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: 36,
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
                  ),
                ],
              ),
            ],
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

  Widget _buildSocialAssetIcon(String assetName, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/$assetName',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.share, color: Colors.white, size: 16),
          ),
        ),
      ),
    );
  }
}

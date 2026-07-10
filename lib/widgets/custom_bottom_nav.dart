import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constants/app_colors.dart';
import '../core/routes/app_routes.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentRoute = Get.currentRoute;
    bool isHome = currentRoute == AppRoutes.home || currentRoute == AppRoutes.smartPost;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        // Transparent on home (Reels) to be immersive, solid elsewhere for visibility
        color: isHome ? Colors.transparent : (isDark ? AppColors.darkBackground : Colors.white),
        border: isHome 
            ? null 
            : Border(top: BorderSide(color: isDark ? Colors.white10 : Colors.black12, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.rocket_launch_outlined, currentRoute == AppRoutes.smartPost, () => Get.offAllNamed(AppRoutes.home), isHome),
          _buildNavItem(Icons.search, currentRoute == AppRoutes.search, () => Get.offAllNamed(AppRoutes.search), isHome),
          _buildNavItem(Icons.home_outlined, currentRoute == AppRoutes.home, () => Get.offAllNamed(AppRoutes.home), isHome),
          _buildNavItem(Icons.chat_bubble_outline, currentRoute == AppRoutes.communities, () => Get.offAllNamed(AppRoutes.communities), isHome),
          _buildNavItem(Icons.person_outline, currentRoute == AppRoutes.profile, () => Get.offAllNamed(AppRoutes.profile), isHome),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive, VoidCallback onTap, bool isHome) {
    Color iconColor;
    if (isHome) {
      iconColor = isActive ? Colors.white : Colors.white.withOpacity(0.7);
    } else {
      iconColor = isActive ? AppColors.accent : AppColors.grey;
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 28,
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: iconColor,
                shape: BoxShape.circle,
              ),
            )
        ],
      ),
    );
  }
}

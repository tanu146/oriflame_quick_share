import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constants/app_colors.dart';
import '../core/routes/app_routes.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final String currentRoute = Get.currentRoute;

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff1A1A1A) : AppColors.black,
        border: Border(top: BorderSide(
          color: isDark ? Colors.white10 : Colors.white12, 
          width: 0.5
        )),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.rocket_launch_outlined, currentRoute == AppRoutes.smartPost, () => Get.offAllNamed(AppRoutes.home)),
          _buildNavItem(Icons.search, currentRoute == AppRoutes.search, () => Get.offAllNamed(AppRoutes.search)),
          _buildNavItem(Icons.home, currentRoute == AppRoutes.home, () => Get.offAllNamed(AppRoutes.home)),
          _buildNavItem(Icons.chat_bubble_outline, currentRoute == AppRoutes.communities, () => Get.offAllNamed(AppRoutes.communities)),
          _buildNavItem(Icons.person_outline, currentRoute == AppRoutes.profile, () => Get.offAllNamed(AppRoutes.profile)),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.white : Colors.white60,
            size: 28,
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            )
        ],
      ),
    );
  }
}

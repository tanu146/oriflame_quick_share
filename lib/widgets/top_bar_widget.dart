import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constants/app_colors.dart';
import '../controllers/home_controller.dart';
import '../core/routes/app_routes.dart';

class TopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final String currentRoute = Get.currentRoute;

    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      toolbarHeight: 80,
      leadingWidth: 100,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/app_icon.png',
            width: 32,
            height: 32,
            errorBuilder: (context, error, stackTrace) => Stack(
              alignment: Alignment.topRight,
              children: [
                Icon(Icons.radio_button_checked, 
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.black, 
                  size: 28),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "AI",
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const Text("Your Assistant", style: TextStyle(color: AppColors.grey, fontSize: 10)),
        ],
      ),
      title: Column(
        children: [
          Text(
            'ORIFLAME',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
              fontSize: 18,
            ),
          ),
          const Text(
            'SWEDEN',
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 8,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        SizedBox(
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => GestureDetector(
                onTap: () => controller.toggleTheme(),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: controller.isDarkMode.value ? AppColors.accent : AppColors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    controller.isDarkMode.value ? Icons.light_mode : Icons.dark_mode,
                    color: controller.isDarkMode.value ? AppColors.black : Colors.white,
                    size: 18,
                  ),
                ),
              )),
              Obx(() => Text(
                controller.isDarkMode.value ? "Light Mode" : "Dark Mode",
                style: const TextStyle(color: AppColors.grey, fontSize: 10),
              )),
            ],
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTabItem(context, "Smart Post", currentRoute == AppRoutes.home || currentRoute == AppRoutes.smartPost, () => Get.offAllNamed(AppRoutes.home)),
              _buildTabItem(context, "Library", currentRoute == AppRoutes.library, () => Get.offAllNamed(AppRoutes.library)),
              _buildTabItem(context, "Communities", currentRoute == AppRoutes.communities, () => Get.offAllNamed(AppRoutes.communities)),
              _buildTabItem(context, "Share&Win", currentRoute == AppRoutes.shareWin, () => Get.offAllNamed(AppRoutes.shareWin)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected 
                  ? AppColors.accent 
                  : (Theme.of(context).brightness == Brightness.dark ? Colors.white60 : AppColors.grey),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 40,
              color: AppColors.accent,
            )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

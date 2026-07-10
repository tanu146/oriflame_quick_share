import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/reel_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/custom_bottom_nav.dart';
import '../core/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller is now global from main.dart
    final HomeController controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: const TopBarWidget(),
      body: Obx(() {
        return PageView.builder(
          controller: controller.pageController,
          scrollDirection: Axis.vertical,
          itemCount: controller.posts.length,
          onPageChanged: controller.onPageChanged,
          itemBuilder: (context, index) {
            return ReelWidget(
              post: controller.posts[index],
              index: index,
              total: controller.posts.length,
            );
          },
        );
      }),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}

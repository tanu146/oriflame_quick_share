import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/reel_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/custom_bottom_nav.dart';
import '../core/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startAudio();
    });
  }

  @override
  void dispose() {
    controller.stopAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      extendBody: true,
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

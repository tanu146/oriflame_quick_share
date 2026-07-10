import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/routes/app_routes.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final List<String> _steps = [
    "Preparing popular content for you",
    "Crafting a caption to boost engagement",
    "Adding your personal referral link and code",
    "Finding trending songs on other social media",
  ];

  final RxInt _currentStep = 0.obs;
  final RxBool _isDone = false.obs;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() async {
    for (int i = 0; i < _steps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 1500));
      _currentStep.value = i + 1;
    }
    _isDone.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Building personalised\nSmart Posts for you!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.black,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.xxl),
              ...List.generate(_steps.length, (index) {
                return Obx(() {
                  bool isCompleted = _currentStep.value > index;
                  bool isCurrent = _currentStep.value == index;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.s),
                    child: Row(
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: isCompleted
                              ? const Icon(Icons.check_circle, color: AppColors.accent, key: ValueKey('done'))
                              : Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isCurrent ? AppColors.accent : (isDark ? Colors.white24 : AppColors.lightGrey),
                                      width: 2,
                                    ),
                                  ),
                                  key: const ValueKey('pending'),
                                  child: isCurrent
                                      ? const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                                          ),
                                        )
                                      : null,
                                ),
                        ),
                        const SizedBox(width: AppSizes.m),
                        Expanded(
                          child: Text(
                            _steps[index],
                            style: TextStyle(
                              color: isCompleted || isCurrent 
                                  ? (isDark ? Colors.white : AppColors.black) 
                                  : AppColors.grey,
                              fontSize: 14,
                              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
              }),
              const SizedBox(height: AppSizes.xl),
              Obx(() {
                if (_isDone.value) {
                  return const Center(
                    child: Text(
                      "All set! Get ready to share...",
                      style: TextStyle(
                        color: AppColors.grey,
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}

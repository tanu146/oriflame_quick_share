import 'package:get/get.dart';

import '../../screens/edit_caption_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/loading_screen.dart';
import '../../screens/landing_screen.dart';
import '../../screens/placeholder_screens.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.landing,
      page: () => const LandingScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.loading,
      page: () => const LoadingScreen(),
    ),
    GetPage(
      name: AppRoutes.editCaption,
      page: () => const EditCaptionScreen(),
    ),
    GetPage(
      name: AppRoutes.library,
      page: () => const LibraryScreen(),
    ),
    GetPage(
      name: AppRoutes.communities,
      page: () => const CommunityScreen(),
    ),
    GetPage(
      name: AppRoutes.shareWin,
      page: () => const LibraryScreen(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchScreen(),
    ),
    GetPage(
      name: AppRoutes.smartPost,
      page: () => const HomeScreen(),
    ),
  ];
}

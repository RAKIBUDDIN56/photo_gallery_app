import 'package:flutter/material.dart';
import 'package:photo_gallery_app/config/route/routes_name.dart';
import 'package:photo_gallery_app/presentation/views/photoPreviewPage/photo_preview_screen.dart';
import 'package:photo_gallery_app/presentation/views/splashPage/splash_screen.dart';

import '../../presentation/views/homePage/home_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.SPLASH:
        return MaterialPageRoute(builder: (_) {
          return const SplashScreen();
         
        });

      case Routes.HOME:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.PHOTO_PREVEW:
        final args = settings.arguments as PhotoPreviewScreenArgs;
        return MaterialPageRoute(
          builder: (context) {
            return PhotoPreviewScreen(args: args);
          },
        );

      default:
        return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:photo_gallery_app/config/route/app_routes.dart';
import 'package:photo_gallery_app/presentation/views/homePage/home_screen.dart';
import 'package:photo_gallery_app/presentation/views/photoPreviewPage/photo_preview_screen.dart';
import 'package:photo_gallery_app/presentation/views/splashPage/splash_screen.dart';

import '../config/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.getAppTheme(context, false),
      routes: {
        '/': (context) => const SplashScreen(),
        // HomeScreen.routeName: (context) => const HomeScreen(),
      },
      onGenerateRoute: AppRouter().onGenerateRoute,
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     case PhotoPreviewScreen.routeName:
      //       {
      //         final args = settings.arguments as PhotoPreviewScreenArgs;
      //         return MaterialPageRoute(
      //           builder: (context) {
      //             return PhotoPreviewScreen(args: args);
      //           },
      //         );
      //       }
      //     default:
      //       {
      //         assert(false, 'Need to implement ${settings.name}');
      //         return null;
      //       }
      //   }
      // },
    );
  }
}

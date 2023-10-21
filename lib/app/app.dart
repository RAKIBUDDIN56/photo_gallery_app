import 'package:flutter/material.dart';
import 'package:photo_gallery_app/config/route/app_routes.dart';
import 'package:photo_gallery_app/presentation/views/splashPage/splash_screen.dart';
import '../config/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getAppTheme(context, false),
      routes: {
        '/': (context) => const SplashScreen(),
      },
      onGenerateRoute: AppRouter().onGenerateRoute,
    );
  }
}

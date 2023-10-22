import 'package:flutter/material.dart';
import 'package:photo_gallery_app/config/route/app_routes.dart';
import '../config/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getAppTheme(context, false),
      initialRoute: '/',
      onGenerateRoute: AppRouter().onGenerateRoute,
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:photo_gallery_app/config/route/routes_name.dart';
import 'package:photo_gallery_app/utils/app_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppConstant.appBackground,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Photo Gallery',
                style: TextStyle(
                  fontFamily: 'Bellania',
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 2), () {}).then((value) {
      Navigator.pushReplacementNamed(context, Routes.HOME);
    });
  }
}

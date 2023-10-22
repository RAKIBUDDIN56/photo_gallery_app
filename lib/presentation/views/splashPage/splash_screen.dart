import 'dart:async';
import 'package:flutter/material.dart';
import 'package:photo_gallery_app/config/route/routes_name.dart';
import 'package:photo_gallery_app/config/constants/app_constant.dart';

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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                AppConstant.appBackground,
              ),
              fit: BoxFit.fill),
        ),
        child: Image.asset(
          AppConstant.appBackground,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 2), () {}).then((value) {
      Navigator.pushReplacementNamed(context, Routes.HOME);
    });
  }
}

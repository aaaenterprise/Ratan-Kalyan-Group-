import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gold/app/data/constant/assets_constant.dart';
import 'package:gold/app/data/constant/color_constant.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorConstant.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsConstant.logo,
              width: 250,
            ),
            const SizedBox(height: 15),
            const CircularProgressIndicator(
              color: Color.fromARGB(255, 188, 84, 35),
            )
          ],
        ),
      ),
    );
  }
}

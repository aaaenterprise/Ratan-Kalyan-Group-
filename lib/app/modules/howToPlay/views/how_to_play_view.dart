import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/url.dart';

import '../controllers/how_to_play_controller.dart';

class HowToPlayView extends GetView<HowToPlayController> {
  const HowToPlayView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('How To Play '), centerTitle: true, backgroundColor:  Color(0xFF6B1C5C) ,),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.sizeOf(context).width * 0.7, 55),
            backgroundColor: const Color(0xFF6B1C5C),
            shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          onPressed: () async {
            String url = controller.userController.setting?.howToPlay ?? "";

            UrlLauncher.launchUrl(url);
          },
          child: const Text(
            'How To Play',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

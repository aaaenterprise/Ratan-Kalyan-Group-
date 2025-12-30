import 'dart:developer';

import 'package:flutter/services.dart';

class UrlLauncher {
  static const platform = MethodChannel('com.example.app/url_launcher');

  static Future<void> launchUrl(String url) async {
    try {
      await platform.invokeMethod('launchUrl', {'url': url});
    } on PlatformException catch (e) {
      log("Failed to launch URL: ${e.message}");
    }
  }
}

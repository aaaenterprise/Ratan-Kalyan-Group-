import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  log("Message title ---> ${message.notification?.title}");
  log("Message body ---> ${message.notification?.body}");
  log("Message data ---> ${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    // Request notification permissions for iOS
    await _firebaseMessaging.requestPermission();
    // Subscribe to a topic (e.g., "news")
    await subscribeToTopic("news");
    // Get the FCM token
    final fCM = await _firebaseMessaging.getToken();
    log("fcm token ---> $fCM");

    // Initialize local notifications
    const androidSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher'); // Specify your app's launcher icon
    const initializationSettings =
        InitializationSettings(android: androidSettings);
    await _localNotificationsPlugin.initialize(initializationSettings);

    // Background notification handler
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    // Foreground notification handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("Foreground message title ---> ${message.notification?.title}");
      log("Foreground message body ---> ${message.notification?.body}");
      log("Foreground message data ---> ${message.data}");

      // Show the notification manually using flutter_local_notifications
      if (message.notification != null) {
        _showNotification(
          title: message.notification!.title ?? 'No Title',
          body: message.notification!.body ?? 'No Body',
        );
      }
    });
  }
  // Subscribe to a specific topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      log("Subscribed to topic: $topic");
    } catch (e) {
       log("Subscription to topic failed: $e");
      // Retry after a delay
      await Future.delayed(const Duration(seconds: 5));
      subscribeToTopic(topic); // Retry subscription
    }
  }

  // Unsubscribe from a topic (optional)
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      log("Unsubscribed from topic: $topic");
    } catch (e) {
      log("Failed to unsubscribe from topic: $e");
    }
  }

  // Method to show local notification
  Future<void> _showNotification(
      {required String title, required String body}) async {
    const androidDetails = AndroidNotificationDetails(
      'your_channel_id', // Replace with your channel ID
      'your_channel_name', // Replace with your channel name
      importance: Importance.high,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      notificationDetails,
    );
  }
}

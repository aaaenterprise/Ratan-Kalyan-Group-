package com.gold.kalyan.matkaplay



import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL_URL_LAUNCHER = "com.example.app/url_launcher"
    private val CHANNEL_SHARED_PREFS = "com.example.app/shared_preferences"
    private val CHANNEL_SHARE = "com.example.app/share"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Method channel for URL Launcher
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_URL_LAUNCHER).setMethodCallHandler { call, result ->
            if (call.method == "launchUrl") {
                val url = call.argument<String>("url")
                if (url != null) {
                    launchUrl(url)
                    result.success(null)
                } else {
                    result.error("INVALID_URL", "URL is null", null)
                }
            } else {
                result.notImplemented()
            }
        }

        // Method channel for Shared Preferences
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_SHARED_PREFS).setMethodCallHandler { call, result ->
            val sharedPreferences: SharedPreferences = getSharedPreferences("FlutterSharedPrefs", Context.MODE_PRIVATE)

            when (call.method) {
                "setString" -> {
                    val key = call.argument<String>("key")
                    val value = call.argument<String>("value")
                    if (key != null && value != null) {
                        sharedPreferences.edit().putString(key, value).apply()
                        result.success(null)
                    } else {
                        result.error("INVALID_ARGUMENTS", "Key or value is null", null)
                    }
                }
                "getString" -> {
                    val key = call.argument<String>("key")
                    if (key != null) {
                        val value = sharedPreferences.getString(key, null)
                        result.success(value)
                    } else {
                        result.error("INVALID_ARGUMENTS", "Key is null", null)
                    }
                }
                "setInt" -> {
                    val key = call.argument<String>("key")
                    val value = call.argument<Int>("value")
                    if (key != null && value != null) {
                        sharedPreferences.edit().putInt(key, value).apply()
                        result.success(null)
                    } else {
                        result.error("INVALID_ARGUMENTS", "Key or value is null", null)
                    }
                }
                "getInt" -> {
                    val key = call.argument<String>("key")
                    if (key != null) {
                        val value = sharedPreferences.getInt(key, -1)
                        result.success(value)
                    } else {
                        result.error("INVALID_ARGUMENTS", "Key is null", null)
                    }
                }
                "clear" -> {
                    sharedPreferences.edit().clear().apply()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }

        // Method channel for Sharing
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_SHARE).setMethodCallHandler { call, result ->
            if (call.method == "shareWithFriend") {
                val message = call.argument<String>("message")
                if (message != null) {
                    shareWithFriend(message)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENTS", "Message is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun launchUrl(url: String) {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
        startActivity(intent)
    }

    private fun shareWithFriend(message: String) {
        val intent = Intent(Intent.ACTION_SEND).apply {
            type = "text/plain"
            putExtra(Intent.EXTRA_TEXT, message)
        }
        startActivity(Intent.createChooser(intent, "Share with"))
    }
}





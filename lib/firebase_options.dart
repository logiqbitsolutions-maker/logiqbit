// File generated based on google-services.json
// Project: logiqbit-solution-web

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS. '
          'Please add a GoogleService-Info.plist to the iOS app.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macOS.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Windows.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  /// Web Firebase options
  /// NOTE: For web, add your web API key from the Firebase Console
  /// (Project Settings → General → Your apps → Web app)
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAW6Yomkufkns0WcRqKFVT4aAFCTJ8dhUM',
    appId: '1:927492670740:web:REPLACE_WITH_WEB_APP_ID',
    messagingSenderId: '927492670740',
    projectId: 'logiqbit-solution-web',
    storageBucket: 'logiqbit-solution-web.firebasestorage.app',
  );

  /// Android Firebase options (from google-services.json)
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAW6Yomkufkns0WcRqKFVT4aAFCTJ8dhUM',
    appId: '1:927492670740:android:6fd72d1458de9b4328ee01',
    messagingSenderId: '927492670740',
    projectId: 'logiqbit-solution-web',
    storageBucket: 'logiqbit-solution-web.firebasestorage.app',
  );
}

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
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'MOCK_API_KEY',
    appId: 'MOCK_APP_ID',
    messagingSenderId: 'MOCK_MESSAGING_SENDER_ID',
    projectId: 'karteji-e367d',
    authDomain: 'karteji-e367d.firebaseapp.com',
    storageBucket: 'karteji-e367d.firebasestorage.app',
    measurementId: 'G-4KNXCFGTE6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'MOCK_API_KEY',
    appId: 'MOCK_APP_ID',
    messagingSenderId: 'MOCK_MESSAGING_SENDER_ID',
    projectId: 'karteji-e367d',
    storageBucket: 'karteji-e367d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'MOCK_API_KEY',
    appId: 'MOCK_APP_ID',
    messagingSenderId: 'MOCK_MESSAGING_SENDER_ID',
    projectId: 'karteji-e367d',
    storageBucket: 'karteji-e367d.firebasestorage.app',
    iosBundleId: 'com.karteji.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'MOCK_API_KEY',
    appId: 'MOCK_APP_ID',
    messagingSenderId: 'MOCK_MESSAGING_SENDER_ID',
    projectId: 'karteji-e367d',
    storageBucket: 'karteji-e367d.firebasestorage.app',
    iosBundleId: 'com.karteji.app',
  );
}

// FILE: lib/firebase_options.dart
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
    apiKey: 'AIzaSyCvHkrROTRHi5dw6CXKEXCHiDxdWT4Y7Zg',
    appId: '1:217557943888:web:176340e4e6f878c2487355',
    messagingSenderId: '217557943888',
    projectId: 'football-manager-fcm-app',
    authDomain: 'football-manager-fcm-app.firebaseapp.com',
    storageBucket: 'football-manager-fcm-app.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCvHkrROTRHi5dw6CXKEXCHiDxdWT4Y7Zg',
    appId: '1:217557943888:web:176340e4e6f878c2487355',
    messagingSenderId: '217557943888',
    projectId: 'football-manager-fcm-app',
    storageBucket: 'football-manager-fcm-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvHkrROTRHi5dw6CXKEXCHiDxdWT4Y7Zg',
    appId: '1:217557943888:web:176340e4e6f878c2487355',
    messagingSenderId: '217557943888',
    projectId: 'football-manager-fcm-app',
    storageBucket: 'football-manager-fcm-app.firebasestorage.app',
    iosBundleId: 'com.example.myapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvHkrROTRHi5dw6CXKEXCHiDxdWT4Y7Zg',
    appId: '1:217557943888:web:176340e4e6f878c2487355',
    messagingSenderId: '217557943888',
    projectId: 'football-manager-fcm-app',
    storageBucket: 'football-manager-fcm-app.firebasestorage.app',
    iosBundleId: 'com.example.myapp',
  );
}

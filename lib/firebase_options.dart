
// FILE: lib/firebase_options.dart
// IMPORTANTE: ESTE ES UN ARCHIVO DE EJEMPLO.
// Para que la aplicación se conecte a tu proyecto de Firebase,
// debes reemplazar el contenido de este archivo por el tuyo.
//
// Sigue estos pasos en tu terminal:
// 1. Si no lo has hecho, instala el CLI de Firebase: npm install -g firebase-tools
// 2. Ejecuta: firebase login
// 3. Ejecuta: flutterfire configure
// 4. Sigue los pasos en pantalla. Esto generará un NUEVO `firebase_options.dart`
//    con tus propias claves. Sobrescribe este archivo con el nuevo.

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
    apiKey: 'REEMPLAZAR-CON-TU-API-KEY',
    appId: 'REEMPLAZAR-CON-TU-APP-ID',
    messagingSenderId: '000000000000',
    projectId: 'tu-project-id',
    authDomain: 'tu-project-id.firebaseapp.com',
    storageBucket: 'tu-project-id.appspot.com',
    measurementId: 'G-XXXXXXXXXX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'REEMPLAZAR-CON-TU-API-KEY',
    appId: 'REEMPLAZAR-CON-TU-APP-ID',
    messagingSenderId: '000000000000',
    projectId: 'tu-project-id',
    storageBucket: 'tu-project-id.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'REEMPLAZAR-CON-TU-API-KEY',
    appId: 'REEMPLAZAR-CON-TU-APP-ID',
    messagingSenderId: '000000000000',
    projectId: 'tu-project-id',
    storageBucket: 'tu-project-id.appspot.com',
    iosBundleId: 'com.example.myapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'REEMPLAZAR-CON-TU-API-KEY',
    appId: 'REEMPLAZAR-CON-TU-APP-ID',
    messagingSenderId: '000000000000',
    projectId: 'tu-project-id',
    storageBucket: 'tu-project-id.appspot.com',
    iosBundleId: 'com.example.myapp',
  );
}

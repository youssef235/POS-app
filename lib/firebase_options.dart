// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        return windows;
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
    apiKey: 'AIzaSyDW-F4p9pbBVfdliPYz2Qx4Z0Bqk3_G-NA',
    appId: '1:516403164987:web:37a5bd7697076e6fdae91e',
    messagingSenderId: '516403164987',
    projectId: 'posapp-b998e',
    authDomain: 'posapp-b998e.firebaseapp.com',
    storageBucket: 'posapp-b998e.appspot.com',
    measurementId: 'G-6BF05KCSX6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJQYvLS0B0h6s5dS6WujdBFyQZWgeHv-Q',
    appId: '1:516403164987:android:d834bf9388d352dadae91e',
    messagingSenderId: '516403164987',
    projectId: 'posapp-b998e',
    storageBucket: 'posapp-b998e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbsEnko20sIrcDv9RptJwpR9R6OwwCUtM',
    appId: '1:516403164987:ios:52d138d02040a04ddae91e',
    messagingSenderId: '516403164987',
    projectId: 'posapp-b998e',
    storageBucket: 'posapp-b998e.appspot.com',
    iosBundleId: 'com.example.posClientFinal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBbsEnko20sIrcDv9RptJwpR9R6OwwCUtM',
    appId: '1:516403164987:ios:52d138d02040a04ddae91e',
    messagingSenderId: '516403164987',
    projectId: 'posapp-b998e',
    storageBucket: 'posapp-b998e.appspot.com',
    iosBundleId: 'com.example.posClientFinal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDW-F4p9pbBVfdliPYz2Qx4Z0Bqk3_G-NA',
    appId: '1:516403164987:web:0824ce0329d0507ddae91e',
    messagingSenderId: '516403164987',
    projectId: 'posapp-b998e',
    authDomain: 'posapp-b998e.firebaseapp.com',
    storageBucket: 'posapp-b998e.appspot.com',
    measurementId: 'G-3THEESFFC0',
  );
}

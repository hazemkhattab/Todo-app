// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyAGb1STZ0rJS5qbgkw2PU9CNBIKJ1oScZo',
    appId: '1:322305256724:web:d628973d3cdb5747056601',
    messagingSenderId: '322305256724',
    projectId: 'final-todo-app-7bdc8',
    authDomain: 'final-todo-app-7bdc8.firebaseapp.com',
    storageBucket: 'final-todo-app-7bdc8.appspot.com',
    measurementId: 'G-B1TBYET9MT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCbmCBTKzsgd5QoZHITL2SDuFH2D-E50tY',
    appId: '1:322305256724:android:e5b60d26a1460d59056601',
    messagingSenderId: '322305256724',
    projectId: 'final-todo-app-7bdc8',
    storageBucket: 'final-todo-app-7bdc8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD1EI3VnR4CwhdPnY0lGcxhEa_pp58NRSk',
    appId: '1:322305256724:ios:18665baa0b15db89056601',
    messagingSenderId: '322305256724',
    projectId: 'final-todo-app-7bdc8',
    storageBucket: 'final-todo-app-7bdc8.appspot.com',
    iosBundleId: 'com.example.untitled',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD1EI3VnR4CwhdPnY0lGcxhEa_pp58NRSk',
    appId: '1:322305256724:ios:90f0a26e91026db9056601',
    messagingSenderId: '322305256724',
    projectId: 'final-todo-app-7bdc8',
    storageBucket: 'final-todo-app-7bdc8.appspot.com',
    iosBundleId: 'com.example.untitled.RunnerTests',
  );
}

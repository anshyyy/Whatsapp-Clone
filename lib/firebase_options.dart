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
    apiKey: 'AIzaSyB4gS9reJ0-dD6BG4CpThBvBcZ9iiCp6_o',
    appId: '1:418691818841:web:0db898d440f56632de5848',
    messagingSenderId: '418691818841',
    projectId: 'whatsapp-bcbcc',
    authDomain: 'whatsapp-bcbcc.firebaseapp.com',
    storageBucket: 'whatsapp-bcbcc.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDa7sRj7PTx-0-1u4QOUNPNJQ3ghZijrVI',
    appId: '1:418691818841:android:d4c857fbc60d2b93de5848',
    messagingSenderId: '418691818841',
    projectId: 'whatsapp-bcbcc',
    storageBucket: 'whatsapp-bcbcc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAd1f6v0hvycRP8wWDIYQkFIQoD3YMV6yk',
    appId: '1:418691818841:ios:63c7ab6815dd822ade5848',
    messagingSenderId: '418691818841',
    projectId: 'whatsapp-bcbcc',
    storageBucket: 'whatsapp-bcbcc.appspot.com',
    iosClientId: '418691818841-srpdqrjj8hm84m5kt8ca52fjachj994s.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAd1f6v0hvycRP8wWDIYQkFIQoD3YMV6yk',
    appId: '1:418691818841:ios:5e136fd1ba9ee43ade5848',
    messagingSenderId: '418691818841',
    projectId: 'whatsapp-bcbcc',
    storageBucket: 'whatsapp-bcbcc.appspot.com',
    iosClientId: '418691818841-uj1o0jo8ohrnin6gkb48ghvetcfl97qr.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsapp.RunnerTests',
  );
}

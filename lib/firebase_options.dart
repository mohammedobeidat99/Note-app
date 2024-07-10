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
    apiKey: 'AIzaSyAKBtC7Z9iOkGq6tusQlDiYe3FepS6aiMI',
    appId: '1:819838348053:web:9186219556e3eed5b9571c',
    messagingSenderId: '819838348053',
    projectId: 'note-9d2df',
    authDomain: 'note-9d2df.firebaseapp.com',
    storageBucket: 'note-9d2df.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAFQVNdLV1sS2um3w61kZm12JBC3oEYwLc',
    appId: '1:819838348053:android:e00331856ad3d0beb9571c',
    messagingSenderId: '819838348053',
    projectId: 'note-9d2df',
    storageBucket: 'note-9d2df.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDH_y2yXdcOl9R7d92pde4mLtY4LMoKyjo',
    appId: '1:819838348053:ios:7186d115fd29d47db9571c',
    messagingSenderId: '819838348053',
    projectId: 'note-9d2df',
    storageBucket: 'note-9d2df.appspot.com',
    iosBundleId: 'com.example.noteApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDH_y2yXdcOl9R7d92pde4mLtY4LMoKyjo',
    appId: '1:819838348053:ios:4fe682b11ed4b41eb9571c',
    messagingSenderId: '819838348053',
    projectId: 'note-9d2df',
    storageBucket: 'note-9d2df.appspot.com',
    iosBundleId: 'com.example.noteApp.RunnerTests',
  );
}
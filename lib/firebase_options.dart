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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBbOEFjj5fcHebkCsX2jak_wr0y2_H5uAc',
    appId: '1:363605058948:web:c1b7abebe695a63d28a9d1',
    messagingSenderId: '363605058948',
    projectId: 'transcribe-894d3',
    authDomain: 'transcribe-894d3.firebaseapp.com',
    storageBucket: 'transcribe-894d3.appspot.com',
    measurementId: 'G-83DERQF75H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmZwGjlYuW1qfl3pVSTboyhlJDJK8dPf8',
    appId: '1:363605058948:android:39a58f52478482b628a9d1',
    messagingSenderId: '363605058948',
    projectId: 'transcribe-894d3',
    storageBucket: 'transcribe-894d3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCErrtyYRnrs29ioxHOOcQ-1LowUAzgUgQ',
    appId: '1:363605058948:ios:25a8b8b81604d4dc28a9d1',
    messagingSenderId: '363605058948',
    projectId: 'transcribe-894d3',
    storageBucket: 'transcribe-894d3.appspot.com',
    iosBundleId: 'com.example.transcribe',
  );

}
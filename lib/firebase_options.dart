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
    apiKey: 'AIzaSyDY4PJt8ynyJ43yNr7qxxGZRb0vCShomWk',
    appId: '1:582257432397:web:264e3e502a440dfdf0c904',
    messagingSenderId: '582257432397',
    projectId: 'dmhelper-1aa5d',
    authDomain: 'dmhelper-1aa5d.firebaseapp.com',
    storageBucket: 'dmhelper-1aa5d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWGQCuHhNF0o4qVAYycN0jvBHWCsR8XlE',
    appId: '1:582257432397:android:05e252e362ec9a2af0c904',
    messagingSenderId: '582257432397',
    projectId: 'dmhelper-1aa5d',
    storageBucket: 'dmhelper-1aa5d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHbJVFdAWbgca05qC5hb-_RAYDFuldvgc',
    appId: '1:582257432397:ios:bee8f67e58ed3c33f0c904',
    messagingSenderId: '582257432397',
    projectId: 'dmhelper-1aa5d',
    storageBucket: 'dmhelper-1aa5d.appspot.com',
    iosClientId: '582257432397-frs7otafcr4lj8r857fgsc32h2die3ee.apps.googleusercontent.com',
    iosBundleId: 'com.example.dmHelper',
  );
}

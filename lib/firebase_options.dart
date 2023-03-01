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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKgw7Y7wz-hmuIBSmyhdbAw2bYM8zG6cU',
    appId: '1:811640708019:android:d6902f6d7b4581f84cc9c6',
    messagingSenderId: '811640708019',
    projectId: 'tworoomsample',
    storageBucket: 'tworoomsample.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvpFh9Y08UE8MQcL6y6dkKZZ2xY_ptyrQ',
    appId: '1:811640708019:ios:af064242c3e5575e4cc9c6',
    messagingSenderId: '811640708019',
    projectId: 'tworoomsample',
    storageBucket: 'tworoomsample.appspot.com',
    androidClientId: '811640708019-jtd8137l5tp3gudknmbh3ni22fl5is3u.apps.googleusercontent.com',
    iosClientId: '811640708019-lefvkavfvo0h36ltofg6nmgk6b6vbihq.apps.googleusercontent.com',
    iosBundleId: 'com.xraph.plugin.fuwPluginExample',
  );
}

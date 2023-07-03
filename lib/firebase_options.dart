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
    apiKey: 'AIzaSyBHj0crMg9pSnxdKypWEtnmhoA8omw-U_0',
    appId: '1:72282570770:web:77e4ec2a004df4b5d498cb',
    messagingSenderId: '72282570770',
    projectId: 'filmoteca-d8757',
    authDomain: 'filmoteca-d8757.firebaseapp.com',
    storageBucket: 'filmoteca-d8757.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRvfDELXsjdXBlzJo4J5kFEBCWh4pt5aU',
    appId: '1:72282570770:android:fdee2b93e5db5587d498cb',
    messagingSenderId: '72282570770',
    projectId: 'filmoteca-d8757',
    storageBucket: 'filmoteca-d8757.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAPGX8ebasOUoWBVRrCf6C_lQRx6LiRS2Q',
    appId: '1:72282570770:ios:9dcf5608fd331fbbd498cb',
    messagingSenderId: '72282570770',
    projectId: 'filmoteca-d8757',
    storageBucket: 'filmoteca-d8757.appspot.com',
    iosClientId:
        '72282570770-4pgihn2l967siv7ibk2l4bqsqkeunov0.apps.googleusercontent.com',
    iosBundleId: 'com.ucan.filmoteca',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAPGX8ebasOUoWBVRrCf6C_lQRx6LiRS2Q',
    appId: '1:72282570770:ios:9dcf5608fd331fbbd498cb',
    messagingSenderId: '72282570770',
    projectId: 'filmoteca-d8757',
    storageBucket: 'filmoteca-d8757.appspot.com',
    iosClientId:
        '72282570770-4pgihn2l967siv7ibk2l4bqsqkeunov0.apps.googleusercontent.com',
    iosBundleId: 'com.ucan.filmoteca',
  );
}

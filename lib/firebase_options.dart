
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyD8ggElUAjOqDD_oeGDsbjasG1NOD6CeEk',
    appId: '1:951740327092:web:31166775e1e87e0f68e3e1',
    messagingSenderId: '951740327092',
    projectId: 'projeto-ost',
    authDomain: 'projeto-ost.firebaseapp.com',
    storageBucket: 'projeto-ost.appspot.com',
    measurementId: 'G-712HF37WXB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAPGGNwkl1OMqxvMYiU5M2Qk6a2v2KD5z8',
    appId: '1:951740327092:android:0dbcfdf3d2eb95b768e3e1',
    messagingSenderId: '951740327092',
    projectId: 'projeto-ost',
    storageBucket: 'projeto-ost.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCrIo1m-ZBL2TOwF6Pl9jzPSJixq-3ciCc',
    appId: '1:951740327092:ios:387bf244ab8f6f1568e3e1',
    messagingSenderId: '951740327092',
    projectId: 'projeto-ost',
    storageBucket: 'projeto-ost.appspot.com',
    iosBundleId: 'com.example.ost',
  );
}

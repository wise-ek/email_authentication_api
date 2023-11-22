import 'package:firebase_core/firebase_core.dart';

class Authentication {
  static Future<FirebaseApp> initialiseFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
}
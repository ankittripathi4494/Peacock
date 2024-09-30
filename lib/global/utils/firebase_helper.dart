import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pecockapp/firebase_options.dart';

class FirebaseHelper {
  static final FirebaseHelper _instance = FirebaseHelper._internal();

  static late FirebaseAnalytics firebaseAnalytics;
  static late FirebaseAuth firebaseAuth;
  static late GoogleSignIn googleSignIn;
  static late FirebaseMessaging messaging;
  static late FirebaseFirestore firebaseFirestore;

  // Private constructor
  FirebaseHelper._internal();

  // Public factory method to provide access to the singleton instance
  factory FirebaseHelper() {
    return _instance;
  }

  // Initialize the SharedPreferences instance
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseAnalytics = FirebaseAnalytics.instance;
    firebaseAuth = FirebaseAuth.instance;
    googleSignIn = GoogleSignIn();
    messaging = FirebaseMessaging.instance;
    firebaseFirestore = FirebaseFirestore.instance;
  }

  static Future<String?> generateFirebaseToken() async {
    return await messaging.getToken();
  }
}

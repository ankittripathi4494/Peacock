import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pecockapp/firebase_options.dart';

class FirebaseHelper {
  static final FirebaseHelper _instance = FirebaseHelper._internal();

  static late FirebaseAnalytics firebaseAnalytics;
  static late FirebaseAuth firebaseAuth;

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
  }
}

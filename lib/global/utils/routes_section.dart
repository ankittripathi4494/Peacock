import 'package:flutter/material.dart';
import 'package:pecockapp/modules/error/screens/internet_not_found_screen.dart';
import 'package:pecockapp/modules/error/screens/page_not_found_screen.dart';
import 'package:pecockapp/modules/login/screens/login_screen.dart';
import 'package:pecockapp/modules/splash/screens/splash_screen.dart';

class RoutesSection {
  static Route<dynamic> routers(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/':
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => SplashScreen(
              argus: args,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => SplashScreen(
            argus: const {},
          ),
        );
      case '/login':
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => LoginScreen(
              argus: args,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => LoginScreen(
            argus: const {},
          ),
        );
      case '/internet-disconnect':
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => InternetNotFoundScreen(
              argus: args,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => InternetNotFoundScreen(
            argus: const {},
          ),
        );
      default:
        return errorRoute(settings);
    }
  }

  static Route<dynamic> errorRoute(RouteSettings settings) {
    var args = settings.arguments;
    if (args is Map<String, dynamic>) {
      return MaterialPageRoute(
        builder: (context) => PageNotFoundScreen(
          argus: args,
        ),
      );
    }
    return MaterialPageRoute(
      builder: (context) => PageNotFoundScreen(
        argus: const {},
      ),
    );
  }
}

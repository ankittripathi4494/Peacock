import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pecockapp/modules/business/screens/business_screen.dart';
import 'package:pecockapp/modules/camera/screens/camera_screen.dart';
import 'package:pecockapp/modules/customer/bloc/customer_bloc.dart';
import 'package:pecockapp/modules/customer/screens/add_customer_screen.dart';
import 'package:pecockapp/modules/customer/screens/customer_screen.dart';
import 'package:pecockapp/modules/customer/screens/edit_customer_screen.dart';
import 'package:pecockapp/modules/dashboard/screens/dashboard_screen.dart';
import 'package:pecockapp/modules/error/screens/internet_not_found_screen.dart';
import 'package:pecockapp/modules/error/screens/page_not_found_screen.dart';
import 'package:pecockapp/modules/login/bloc/login_bloc.dart';
import 'package:pecockapp/modules/login/screens/login_screen.dart';
import 'package:pecockapp/modules/profile/screens/profile_screen.dart';
import 'package:pecockapp/modules/register/bloc/register_bloc.dart';
import 'package:pecockapp/modules/register/screens/register_screen.dart';
import 'package:pecockapp/modules/splash/screens/splash_screen.dart';

class RoutesSection {
  static Route<dynamic> routers(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/':
        if (args is Map<String, dynamic>) {
          return PageTransition(
              duration: Durations.medium4,
              type: PageTransitionType.fade,
              child: SplashScreen(
                argus: args,
              ));
        }
        return PageTransition(
            duration: Durations.medium4,
            type: PageTransitionType.fade,
            child: SplashScreen(
              argus: const {},
            ));
      case '/login':
        if (args is Map<String, dynamic>) {
          return PageTransition(
            duration: Durations.medium4,
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => LoginBloc(),
              child: LoginScreen(
                argus: args,
              ),
            ),
          );
        }
        return PageTransition(
          duration: Durations.medium4,
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => LoginBloc(),
            child: LoginScreen(
              argus: const {},
            ),
          ),
        );
      case '/camera':
        if (args is Map<String, dynamic>) {
          return PageTransition(
            duration: Durations.medium4,
            type: PageTransitionType.fade,
            child: CameraScreen(
              argus: args,
            ),
          );
        }
        return PageTransition(
          duration: Durations.medium4,
          type: PageTransitionType.fade,
          child: CameraScreen(
            argus: const {},
          ),
        );
      case '/register':
        if (args is Map<String, dynamic>) {
          return PageTransition(
            duration: Durations.medium4,
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => RegisterBloc(),
              child: RegisterScreen(
                argus: args,
              ),
            ),
          );
        }
        return PageTransition(
          duration: Durations.medium4,
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => RegisterBloc(),
            child: RegisterScreen(
              argus: const {},
            ),
          ),
        );
      case '/dashboard':
        if (args is Map<String, dynamic>) {
          return PageTransition(
            duration: Durations.medium4,
            type: PageTransitionType.fade,
            child: DashboardScreen(
              argus: args,
            ),
          );
        }
        return PageTransition(
          duration: Durations.medium4,
          type: PageTransitionType.fade,
          child: DashboardScreen(
            argus: const {},
          ),
        );
      case '/profile':
        if (args is Map<String, dynamic>) {
          return PageTransition(
            duration: Durations.medium4,
            type: PageTransitionType.fade,
            child: ProfileScreen(
              argus: args,
            ),
          );
        }
        return PageTransition(
          duration: Durations.medium4,
          type: PageTransitionType.fade,
          child: ProfileScreen(
            argus: const {},
          ),
        );
      case '/customer-list':
        if (args is Map<String, dynamic>) {
          return PageTransition(
            duration: Durations.medium4,
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => CustomerBloc(),
              child: CustomerScreen(
                argus: args,
              ),
            ),
          );
        }
        return PageTransition(
          duration: Durations.medium4,
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => CustomerBloc(),
            child: CustomerScreen(
              argus: const {},
            ),
          ),
        );
      case '/add-customer':
        if (args is Map<String, dynamic>) {
          return PageTransition(
            duration: Durations.medium4,
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => CustomerBloc(),
              child: AddCustomerScreen(
                argus: args,
              ),
            ),
          );
        }
        return PageTransition(
          duration: Durations.medium4,
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => CustomerBloc(),
            child: AddCustomerScreen(
              argus: const {},
            ),
          ),
        );
      case '/edit-customer':
        if (args is Map<String, dynamic>) {
          return PageTransition(
            duration: Durations.medium4,
            type: PageTransitionType.fade,
            child: BlocProvider(
              create: (context) => CustomerBloc(),
              child: EditCustomerScreen(
                argus: args,
              ),
            ),
          );
        }
        return PageTransition(
          duration: Durations.medium4,
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (context) => CustomerBloc(),
            child: EditCustomerScreen(
              argus: const {},
            ),
          ),
        );
      case '/business':
        if (args is Map<String, dynamic>) {
          return PageTransition(
            duration: Durations.medium4,
            type: PageTransitionType.fade,
            child: BusinessScreen(
              argus: args,
            ),
          );
        }
        return PageTransition(
          duration: Durations.medium4,
          type: PageTransitionType.fade,
          child: BusinessScreen(
            argus: const {},
          ),
        );
      case '/internet-disconnect':
        if (args is Map<String, dynamic>) {
          return PageTransition(
            duration: Durations.medium4,
            type: PageTransitionType.fade,
            child: InternetNotFoundScreen(
              argus: args,
            ),
          );
        }
        return PageTransition(
          duration: Durations.medium4,
          type: PageTransitionType.fade,
          child: InternetNotFoundScreen(
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
      return PageTransition(
        duration: Durations.medium4,
        type: PageTransitionType.fade,
        child: PageNotFoundScreen(
          argus: args,
        ),
      );
    }
    return PageTransition(
      duration: Durations.medium4,
      type: PageTransitionType.fade,
      child: PageNotFoundScreen(
        argus: const {},
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/blocs/internet/internet_cubit.dart';
import 'package:pecockapp/global/utils/firebase_helper.dart';
import 'package:pecockapp/global/utils/routes_section.dart';
import 'package:pecockapp/global/utils/shared_preferences_helper.dart';
import 'package:pecockapp/modules/customer/bloc/customer_bloc.dart';
import 'package:pecockapp/modules/login/bloc/login_bloc.dart';
import 'package:pecockapp/modules/register/bloc/register_bloc.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesHelper().init();
  await FirebaseHelper().init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
  //x
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //every upcoming blocs must be register here
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider<CustomerBloc>(
          create: (context) => CustomerBloc(),
        )
      ],
      child: const MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RoutesSection.routers,
      ),
    ); // MaterialApp refers the material app or flutter app
  }
}

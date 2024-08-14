import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pecockapp/global/blocs/internet/internet_cubit.dart';
import 'package:pecockapp/global/utils/routes_section.dart';

void main() {
  runApp(const MyApp()); //x
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
        )
      ],
      child: const MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RoutesSection.routers,
      ),
    ); // MaterialApp refers the material app or flutter app
  }
}

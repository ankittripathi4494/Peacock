import 'package:flutter/material.dart';
import 'package:pecockapp/routes_section.dart';

void main() {
  runApp(const MyApp()); //x
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
    
      initialRoute: '/',
    onGenerateRoute: RoutesSection.routers,
    ); // MaterialApp refers the material app or flutter app
  }
}

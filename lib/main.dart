import 'package:animals_database/page/animalInfopage.dart';
import 'package:animals_database/page/homepage.dart';
import 'package:animals_database/page/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'splash',
      routes: {
        "/": (context) => HomePage(),
        "splash": (context) => SplashScreen(),
        "animated": (context) => AnimalData()
      },
    );
  }
}

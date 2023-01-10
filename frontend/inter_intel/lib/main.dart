import 'package:flutter/material.dart';
import 'package:inter_intel/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
    );
  }
}



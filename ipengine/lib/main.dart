import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/screens/home_screen.dart';
import 'package:ipengine/features/presentation/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IPengine',
      home: LoginScreen(),
    );
  }
}

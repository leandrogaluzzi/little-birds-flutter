import 'package:flutter/material.dart';
import 'package:little_birds/screens/main_screen.dart';

void main() => runApp(LittleBirdsApp());

class LittleBirdsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

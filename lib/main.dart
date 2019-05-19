import 'package:flutter/material.dart';
import 'package:little_birds/widgets/tab_bar_widget.dart';

void main() => runApp(LittleBirdsApp());

class LittleBirdsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabBarWidget(),
    );
  }
}

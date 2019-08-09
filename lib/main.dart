import 'package:flutter/material.dart';
import 'package:little_birds/screens/main_screen.dart';
import 'package:little_birds/utils/themes.dart';

/*
TODO:

- Instagram Visual
- Find fonts
- Main Screen error feedback when loading cards
- CardScreen - Placeholder Image
- CardScreen - Fix or Replace library
- Filter
- Search
- Make Search bar permanent
- Home Layout
- Home Infinite Scroll
- Deck Screen
- Main Screen
- Firebase - Anaytics
- Unit Tests
- Widget Tests
- Firebase - Ads (future)
- Local DB for cards (future)
*/

void main() => runApp(LittleBirdsApp());

class LittleBirdsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      theme: Themes.app(),
    );
  }
}

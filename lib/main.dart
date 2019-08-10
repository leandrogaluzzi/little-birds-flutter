import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:little_birds/screens/main_screen.dart';
import 'package:little_birds/utils/themes.dart';

/*
TODO:

- Find fonts
- Main Screen error feedback when loading cards
- CardScreen - Placeholder Image
- Filter
- Home Infinite Scroll
- Deck Screen
- Main Screen
- Firebase - Anaytics
- Image Screen animation
- Transitions
- Config CodeMagic.io
- Unit Tests (future)
- Widget Tests (future)
- Firebase - Ads (future)
- Local DB for cards (future)
*/

void main() => runApp(LittleBirdsApp());

class LittleBirdsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      theme: Themes.app(),
    );
  }
}

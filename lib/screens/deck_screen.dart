import 'package:flutter/material.dart';
import 'package:little_birds/model/thrones_deck.dart';

class DeckScreen extends StatelessWidget {
  DeckScreen({
    Key key,
    @required this.deck,
  })  : assert(deck != null),
        super(key: key);

  final ThronesDeck deck;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }
}
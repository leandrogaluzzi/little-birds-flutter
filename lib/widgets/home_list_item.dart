import 'package:flutter/material.dart';
import 'package:little_birds/model/deck.dart';

class HomeListItem extends StatelessWidget {
  HomeListItem({
    Key key,
    @required this.deck,
    @required this.onTap,
  })  : assert(deck != null),
        super(key: key);

  final Deck deck;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(deck.name),
      ),
    );
  }
}

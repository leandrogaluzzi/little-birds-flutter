import 'package:flutter/material.dart';
import 'package:little_birds/model/card.dart';
import 'package:little_birds/widgets/card_list.dart';

class PackScreen extends StatelessWidget {
  PackScreen({
    Key key,
    @required this.title,
    @required this.cards,
  })  : assert(title != null),
        assert(cards != null),
        super(key: key);

  final List<CardItem> cards;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CardList(
        cards: cards,
      ),
    );
  }
}

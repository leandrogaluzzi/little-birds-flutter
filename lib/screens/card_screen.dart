import 'package:flutter/material.dart';
import 'package:little_birds/model/card.dart';

class CardScreen extends StatelessWidget {

  CardScreen({
    Key key,
    @required this.card,
  })  : assert(card != null),
        super(key: key);

  final CardItem card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
      ),
      body: Container(),
    );
  }
}
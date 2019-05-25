import 'package:flutter/material.dart';
import 'package:little_birds/model/card.dart';

class CardsStore extends InheritedWidget {
  CardsStore({
    Key key,
    @required this.cards,
    @required Widget child,
  })  : assert(cards != null),
        assert(child != null),
        super(key: key, child: child);

  final List<CardItem> cards;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

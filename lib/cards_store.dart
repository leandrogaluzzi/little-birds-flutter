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

  static CardsStore of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(CardsStore) as CardsStore;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  List<CardItem> getCardsAlphabetically() {
    var sortedCards = cards;
    sortedCards.sort((a, b) => a.name.compareTo(b.name));
    return sortedCards;
  }

  List<CardItem> getCardsWithPackCode(String packCode) {
    var filteredCards =
        cards.where((card) => card.packCode == packCode).toList();
    return filteredCards;
  }
}

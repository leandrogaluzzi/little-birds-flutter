import 'package:flutter/material.dart';
import 'package:little_birds/model/thrones_card.dart';

class CardsStore extends InheritedWidget {
  CardsStore({
    Key key,
    @required this.cards,
    @required Widget child,
  })  : assert(cards != null),
        assert(child != null),
        super(key: key, child: child);

  final List<ThronesCard> cards;

  static CardsStore of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(CardsStore) as CardsStore;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  List<ThronesCard> getCardsAlphabetically() {
    var sortedCards = cards;
    sortedCards.sort((a, b) => a.name.compareTo(b.name));
    return sortedCards;
  }

  List<ThronesCard> getCardsWithPackCode(String packCode) {
    var filteredCards =
        cards.where((card) => card.packCode == packCode).toList();
    return filteredCards;
  }

  List<ThronesCard> getCardsWithQuery(String query) {
    var filteredCards = cards
        .where((card) => card.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filteredCards;
  }

  List<ThronesCard> getCardsWithCodes(List<String> codes) {
    return cards.where((card) {
      return codes.contains(card.code) ? true : false;
    }).toList();
  }
}

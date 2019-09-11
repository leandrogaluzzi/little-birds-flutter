import 'package:flutter/material.dart';
import 'package:little_birds/model/card_quantity.dart';
import 'package:little_birds/model/slot.dart';
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
    var filteredCards = cards.where(
      (card) {
        bool name = card.name.toLowerCase().contains(query.toLowerCase());
        bool traits = card.traits.toLowerCase().contains(query.toLowerCase());
        return name || traits;
      },
    ).toList();
    return filteredCards;
  }

  List<CardQuantity> getCardsQuantityFromSlots(List<Slot> slots) {
    List<String> codes = slots.map((slot) => slot.code).toList();
    codes.sort();
    var cards = _getCardsWithCodes(codes);
    cards.sort((a, b) => a.code.compareTo(b.code));
    List<CardQuantity> cardsQuantity = [];
    for (int i = 0; i < cards.length; i++) {
      final slot = slots[i];
      final card = cards[i];
      CardQuantity cardQuantity =
          CardQuantity(card: card, quantity: slot.quantity);
      cardsQuantity.add(cardQuantity);
    }
    return cardsQuantity;
  }

  List<ThronesCard> _getCardsWithCodes(List<String> codes) {
    return cards.where((card) {
      return codes.contains(card.code) ? true : false;
    }).toList();
  }
}

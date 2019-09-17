import 'package:flutter/material.dart';
import 'package:little_birds/model/card_quantity.dart';
import 'package:little_birds/model/slot.dart';
import 'package:little_birds/model/thrones_card.dart';

class CardsStore {
  final List<ThronesCard> cards;

  CardsStore({
    @required this.cards,
  }) : assert(cards != null);

  List<ThronesCard> cardsAlphabetically() {
    var sortedCards = cards;
    sortedCards.sort((a, b) => a.name.compareTo(b.name));
    return sortedCards;
  }

  List<ThronesCard> cardsWithPackCode(String packCode) {
    return cards.where((card) => card.packCode == packCode).toList();
  }

  List<ThronesCard> cardsWithQuery(String query) {
    return cards.where(
      (card) {
        bool name = card.name.toLowerCase().contains(query.toLowerCase());
        bool traits = card.traits.toLowerCase().contains(query.toLowerCase());
        return name || traits;
      },
    ).toList();
  }

  List<ThronesCard> cardsFromSlots(List<Slot> slots) {
    List<String> codes = slots.map((slot) => slot.code).toList();
    return _cardsWithCodes(codes);
  }

  List<CardQuantity> cardsQuantityFromSlots(List<Slot> slots) {
    List<String> codes = slots.map((slot) => slot.code).toList();
    codes.sort();
    var cards = _cardsWithCodes(codes);
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

  List<ThronesCard> _cardsWithCodes(List<String> codes) {
    return cards.where((card) {
      return codes.contains(card.code) ? true : false;
    }).toList();
  }
}

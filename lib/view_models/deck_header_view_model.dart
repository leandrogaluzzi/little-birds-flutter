import 'package:flutter/foundation.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/model/card_quantity.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/model/type.dart';

class DeckHeaderViewModel {
  DeckHeaderViewModel({
    @required this.deck,
    @required this.cardsStore,
  })  : assert(deck != null),
        assert(cardsStore != null) {
    _setCardsQuantity();
  }

  ThronesDeck deck;
  CardsStore cardsStore;
  List<CardQuantity> cardsQuantity = [];

  void _setCardsQuantity() {
    List<String> codes = deck.slots.map((slot) => slot.code).toList();
    codes.sort();
    var cards = cardsStore.getCardsWithCodes(codes);
    cards.sort((a, b) => a.code.compareTo(b.code));
    for (int i = 0; i < cards.length; i++) {
      final slot = deck.slots[i];
      final card = cards[i];
      CardQuantity cardQuantity =
          CardQuantity(card: card, quantity: slot.quantity);
      cardsQuantity.add(cardQuantity);
    }
  }

  String icon() {
    return deck.icon();
  }

  String name() {
    return deck.name;
  }

  String info() {
    final plotCount = cardsQuantity.fold(0, (total, card) {
      return card.card.cardType() == Type.plot
          ? total + card.quantity
          : total + 0;
    });
    final deckCount = cardsQuantity.fold(0, (total, card) {
      return card.card.cardType() != Type.plot &&
              card.card.cardType() != Type.agenda
          ? total + card.quantity
          : total + 0;
    });
    return 'Plot: $plotCount - Deck: $deckCount';
  }

  String link() {
    return '';
  }
}

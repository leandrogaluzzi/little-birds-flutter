import 'package:flutter/foundation.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/model/card_quantity.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/model/card_type.dart';

class DeckHeaderViewModel {
  DeckHeaderViewModel({
    @required this.deck,
    @required this.cardsStore,
  })  : assert(deck != null),
        assert(cardsStore != null) {
    cardsQuantity = cardsStore.getCardsQuantityFromSlots(deck.slots);
  }

  ThronesDeck deck;
  CardsStore cardsStore;
  List<CardQuantity> cardsQuantity = [];

  String icon() {
    return deck.icon();
  }

  String name() {
    return deck.name;
  }

  String info() {
    final plotCount = cardsQuantity.fold(0, (total, card) {
      return card.card.cardType() == CardType.plot
          ? total + card.quantity
          : total + 0;
    });
    final deckCount = cardsQuantity.fold(0, (total, card) {
      return card.card.cardType() != CardType.plot &&
              card.card.cardType() != CardType.agenda
          ? total + card.quantity
          : total + 0;
    });
    return 'Plot: $plotCount - Deck: $deckCount';
  }
}

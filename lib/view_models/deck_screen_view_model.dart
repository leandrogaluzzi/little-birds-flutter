import 'package:little_birds/cards_store.dart';
import 'package:little_birds/model/card_quantity.dart';
import 'package:little_birds/model/thrones_card.dart';
//import 'package:little_birds/model/slot.dart';
//import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/model/type.dart';

class DeckScreenViewModel {
  DeckScreenViewModel({
    this.deck,
    this.cardsStore,
  })  : assert(deck != null),
        assert(cardsStore != null);

  final ThronesDeck deck;
  final CardsStore cardsStore;

  String link() {
    return deck.link();
  }

  String sectionHeaderTitle({Type type}) {
    final cards = this.cards(type: type);
    final count = cards.fold(0, (total, card) {
      return total + card.quantity;
    });
    switch (type) {
      case Type.agenda:
        return count <= 1 ? 'Agenda' : 'Agenda ($count)';
      case Type.plot:
        return 'Plot ($count)';
      case Type.character:
        return 'Character ($count)';
      case Type.attachment:
        return 'Attachment ($count)';
      case Type.location:
        return 'Location ($count)';
      case Type.event:
        return 'Event ($count)';
      default:
        return '';
    }
  }

  /*List<ThronesCard> agendas() {
    final agendas = cardsStore.getCardsWithCodes(deck.agendas);
    return agendas;
  }*/

  /*List<ThronesCard> slots({Type type}) {
    final codes = deck.slots.map((slot) => slot.code).toList();
    final cards = cardsStore.getCardsWithCodes(codes);
    final filteredCards =
        cards.where((card) => card.cardType() == type).toList();
    return filteredCards;
  }*/

  List<CardQuantity> cards({Type type}) {
    final cardsQuantity = cardsStore.getCardsQuantityFromSlots(deck.slots);
    final filteredCardsQuantity =
        cardsQuantity.where((card) => card.card.cardType() == type).toList();
    filteredCardsQuantity.sort((a, b) => a.card.name.compareTo(b.card.name));
    return filteredCardsQuantity;
  }
}

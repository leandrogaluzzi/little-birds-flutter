import 'package:little_birds/cards_store.dart';
import 'package:little_birds/model/card_quantity.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/model/card_type.dart';

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

  String sectionHeaderTitle({CardType type}) {
    final cards = this.cards(type: type);
    final count = cards.fold(0, (total, card) {
      return total + card.quantity;
    });
    switch (type) {
      case CardType.agenda:
        return count <= 1 ? 'Agenda' : 'Agenda ($count)';
      case CardType.plot:
        return 'Plot ($count)';
      case CardType.character:
        return 'Character ($count)';
      case CardType.attachment:
        return 'Attachment ($count)';
      case CardType.location:
        return 'Location ($count)';
      case CardType.event:
        return 'Event ($count)';
      default:
        return '';
    }
  }

  List<CardQuantity> cards({CardType type}) {
    final cardsQuantity = cardsStore.getCardsQuantityFromSlots(deck.slots);
    final filteredCardsQuantity =
        cardsQuantity.where((card) => card.card.cardType() == type).toList();
    filteredCardsQuantity.sort((a, b) => a.card.name.compareTo(b.card.name));
    return filteredCardsQuantity;
  }

  /*String description() {
    return deck.description;
  }*/
}

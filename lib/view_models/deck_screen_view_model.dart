import 'package:little_birds/cards_store.dart';
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

  String sectionHeaderTitle({Type type}) {
    switch (type) {
      case Type.agenda:
        return 'Agenda';
      case Type.plot:
        return 'Plot';
      case Type.character:
        return 'Character';
      case Type.attachment:
        return 'Attachment';
      case Type.location:
        return 'Location';
      case Type.event:
        return 'Event';
      default:
        return '';
    }
  }

  /*List<ThronesCard> agendas() {
    final agendas = cardsStore.getCardsWithCodes(deck.agendas);
    return agendas;
  }*/

  List<ThronesCard> slots({Type type}) {
    final codes = deck.slots.map((slot) => slot.code).toList();
    final cards = cardsStore.getCardsWithCodes(codes);
    final filteredCards =
        cards.where((card) => card.cardType() == type).toList();
    return filteredCards;
  }
}

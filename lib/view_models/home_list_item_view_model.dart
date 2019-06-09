import 'package:little_birds/model/card.dart';
import 'package:little_birds/model/card_type.dart';

import 'package:little_birds/model/deck.dart';

class HomeListItemViewModel {
  HomeListItemViewModel({
    this.deck,
    this.cards,
  })  : assert(deck != null),
        assert(cards != null);

  final Deck deck;
  final List<CardItem> cards;

  String getName() {
    return deck.name;
  }

  String getFactionName() {
    return deck.factionName;
  }

  String getAgendas() {
    List<String> agendas = deck.agendas.map((code) {
      final card = cards.firstWhere((card) => card.code == code);
      return card.name;
    }).toList();
    return agendas.join(', ');
  }

  String getInfo() {
    int characters = 0;
    int locations = 0;
    int attachments = 0;
    int events = 0;

    deck.slots.forEach((slot) {
      final card = cards.firstWhere((card) => card.code == slot.code);
      switch (card.cardType()) {
        case CardType.character:
          characters = characters + slot.quantity;
          break;
        case CardType.location:
          locations = locations + slot.quantity;
          break;
        case CardType.attachment:
          attachments = attachments + slot.quantity;
          break;
        case CardType.event:
          events = events + slot.quantity;
          break;
        default:
          break;
      }
    });

    return '$characters Characters - $locations Locations - $attachments Attachments - $events Events';
  }
}

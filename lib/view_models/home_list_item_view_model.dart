import 'package:little_birds/model/card_quantity.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/model/card_type.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:little_birds/utils/utils.dart';

class HomeListItemViewModel {
  HomeListItemViewModel({
    this.deck,
    this.cardsQuantity,
  })  : assert(deck != null),
        assert(cardsQuantity != null);

  final ThronesDeck deck;
  final List<CardQuantity> cardsQuantity;

  String name() {
    return deck.name;
  }

  String factionName() {
    return deck.factionName;
  }

  String iconName() {
    return deck.icon();
  }

  String time() {
    final date = DateTime.parse(deck.dateCreation);
    final string = timeago.format(date);
    return capitalize(string);
  }

  String agendas() {
    List<String> agendas = deck.agendas.map((code) {
      final cardQuantity = cardsQuantity
          .firstWhere((cardQuantity) => cardQuantity.card.code == code);
      return cardQuantity.card.name;
    }).toList();
    return agendas.join(', ');
  }

  String details() {
    int characters = 0;
    int locations = 0;
    int attachments = 0;
    int events = 0;

    deck.slots.forEach((slot) {
      final cardQuantity = cardsQuantity
          .firstWhere((cardQuantity) => cardQuantity.card.code == slot.code);
      switch (cardQuantity.card.cardType()) {
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

    return '$characters Characters - $events Events\n$locations Locations - $attachments Attachments ';
  }
}

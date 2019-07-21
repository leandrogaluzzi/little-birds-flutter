import 'package:flutter/material.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/model/type.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:little_birds/utils/utils.dart';
import 'package:little_birds/model/faction.dart' as faction;

class HomeListItemViewModel {
  HomeListItemViewModel({
    this.deck,
    this.cards,
  })  : assert(deck != null),
        assert(cards != null);

  final ThronesDeck deck;
  final List<ThronesCard> cards;

  String name() {
    return deck.name;
  }

  String factionName() {
    return deck.factionName;
  }

  Color factionColor() {
    return faction.getFactionColor(faction: deck.faction());
  }

  Color factionTextColor() {
    return faction.getFactionTextColor(faction: deck.faction());
  }

  String iconName() {
    return deck.cardIconName();
  }

  String time() {
    final date = DateTime.parse(deck.dateCreation);
    final string = timeago.format(date);
    return capitalize(string);
  }

  String agendas() {
    List<String> agendas = deck.agendas.map((code) {
      final card = cards.firstWhere((card) => card.code == code);
      return card.name;
    }).toList();
    return agendas.join(', ');
  }

  String details() {
    int characters = 0;
    int locations = 0;
    int attachments = 0;
    int events = 0;

    deck.slots.forEach((slot) {
      final card = cards.firstWhere((card) => card.code == slot.code);
      switch (card.cardType()) {
        case Type.character:
          characters = characters + slot.quantity;
          break;
        case Type.location:
          locations = locations + slot.quantity;
          break;
        case Type.attachment:
          attachments = attachments + slot.quantity;
          break;
        case Type.event:
          events = events + slot.quantity;
          break;
        default:
          break;
      }
    });

    return '$characters Characters - $events Events\n$locations Locations - $attachments Attachments ';
  }
}

import 'package:flutter/widgets.dart';
import 'package:little_birds/core/cards_store.dart';
import 'package:little_birds/model/card_type.dart';
import 'package:little_birds/model/faction.dart';
import 'package:little_birds/model/filter.dart';
import 'package:little_birds/model/thrones_card.dart';

class CardListScreenViewModel {
  CardListScreenViewModel({
    @required this.cardsStore,
  }) : assert(cardsStore != null);

  final CardsStore cardsStore;

  List<ThronesCard> cards({String query, Filter filter}) {
    List<ThronesCard> cards = [];

    if (query == null || query == '') {
      cards = cardsStore.cardsAlphabetically();
    } else {
      cards = cardsStore.cardsWithQuery(query);
    }

    if (filter.isActive()) {
      final factions =
          filter.factions.length == 0 ? Faction.values : filter.factions;
      final types = filter.types.length == 0 ? CardType.values : filter.types;

      cards = cards.where((card) {
        return factions.contains(card.faction()) &&
            types.contains(card.cardType());
      }).toList();
    }

    return cards;
  }
}

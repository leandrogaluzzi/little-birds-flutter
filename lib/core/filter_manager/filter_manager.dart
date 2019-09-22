import 'package:flutter/material.dart';
import 'package:little_birds/core/cards_store/cards_store.dart';
import 'package:little_birds/model/card_type.dart';
import 'package:little_birds/model/faction.dart';
import 'package:little_birds/model/filter.dart';
import 'package:little_birds/model/thrones_card.dart';

class FilterManager with ChangeNotifier {
  FilterManager({
    @required this.cardsStore,
  })  : _cards = cardsStore.cardsAlphabetically(),
        assert(cardsStore != null);

  final CardsStore cardsStore;

  String _query = '';
  Filter _filter = Filter(factions: [], types: []);
  List<ThronesCard> _cards = [];

  Filter filter() {
    return _filter;
  }

  List<ThronesCard> cards() {
    return _cards;
  }

  void load() {
    _cards = cardsStore.cardsAlphabetically();
  }

  void search({String query}) {
    _query = query;
    _update();
  }

  void factionSelected(Faction faction) {
    _filter.factions.contains(faction)
        ? _filter.factions.remove(faction)
        : _filter.factions.add(faction);
    //_controllerFilter.sink.add(_filter);
    _update();
  }

  void typeSelected(CardType type) {
    _filter.types.contains(type)
        ? _filter.types.remove(type)
        : _filter.types.add(type);
    //_controllerFilter.sink.add(_filter);
    _update();
  }

  void _update() {
    List<ThronesCard> cards = [];

    if (_query == null || _query == '') {
      cards = cardsStore.cardsAlphabetically();
    } else {
      cards = cardsStore.cardsWithQuery(_query);
    }

    if (_filter.isActive()) {
      final factions =
          _filter.factions.length == 0 ? Faction.values : _filter.factions;
      final types = _filter.types.length == 0 ? CardType.values : _filter.types;

      cards = cards.where((card) {
        return factions.contains(card.faction()) &&
            types.contains(card.cardType());
      }).toList();
    }

    _cards = cards;
    notifyListeners();
  }
}

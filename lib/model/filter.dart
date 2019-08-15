import 'package:flutter/material.dart';
import 'package:little_birds/model/card_type.dart';
import 'package:little_birds/model/faction.dart';

class Filter {
  Filter({
    @required this.factions,
    @required this.types,
  })  : assert(factions != null),
        assert(types != null);

  List<Faction> factions;
  List<CardType> types;

  bool isActive() {
    return factions.length > 0 || types.length > 0;
  }
}

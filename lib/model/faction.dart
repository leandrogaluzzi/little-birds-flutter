import 'package:flutter/material.dart';
import 'package:little_birds/utils/constants.dart';

enum Faction {
  baratheon,
  greyjoy,
  lannister,
  martell,
  neutral,
  stark,
  targaryen,
  theNightsWatch,
  tyrell
}

Faction getFaction(String string) {
  switch (string) {
    case 'baratheon':
      return Faction.baratheon;
    case 'greyjoy':
      return Faction.greyjoy;
    case 'lannister':
      return Faction.lannister;
    case 'martell':
      return Faction.martell;
    case 'neutral':
      return Faction.neutral;
    case 'stark':
      return Faction.stark;
    case 'targaryen':
      return Faction.targaryen;
    case 'thenightswatch':
      return Faction.theNightsWatch;
    case 'tyrell':
      return Faction.tyrell;
    default:
      return Faction.neutral;
  }
}

Color getFactionColor({faction: Faction}) {
  switch (faction) {
    case Faction.baratheon:
      return kColorBaratheon;
    case Faction.greyjoy:
      return kColorGreyjoy;
    case Faction.lannister:
      return kColorLannister;
    case Faction.martell:
      return kColorMartell;
    case Faction.stark:
      return kColorStark;
    case Faction.targaryen:
      return kColorTargaryen;
    case Faction.theNightsWatch:
      return kColorTheNightsWatch;
    case Faction.tyrell:
      return kColorTyrell;
    default:
      return Colors.transparent;
  }
}

Color getFactionTextColor({faction: Faction}) {
  switch (faction) {
    case Faction.targaryen:
    case Faction.lannister:
    case Faction.theNightsWatch:
    case Faction.greyjoy:
      return Colors.white;
    default:
      return Colors.black;
  }
}

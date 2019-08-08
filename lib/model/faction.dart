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

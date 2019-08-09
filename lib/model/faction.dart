class Faction {
  const Faction._(this._index);

  final int _index;

  static const baratheon = Faction._(0);
  static const greyjoy = Faction._(1);
  static const lannister = Faction._(2);
  static const martell = Faction._(3);
  static const neutral = Faction._(4);
  static const stark = Faction._(5);
  static const targaryen = Faction._(6);
  static const theNightsWatch = Faction._(7);
  static const tyrell = Faction._(8);

  static const List<Faction> values = <Faction>[
    baratheon,
    greyjoy,
    lannister,
    martell,
    neutral,
    stark,
    targaryen,
    theNightsWatch,
    tyrell,
  ];

  static Faction code(String code) {
    switch (code) {
      case 'baratheon':
        return baratheon;
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

  String toCode() {
    return const <int, String>{
      0: 'baratheon',
      1: 'greyjoy',
      2: 'lannister',
      3: 'martell',
      4: 'neutral',
      5: 'stark',
      6: 'targaryen',
      7: 'thenightswatch',
      8: 'tyrell',
    }[_index];
  }

  String toString() {
    return const <int, String>{
      0: 'Baratheon',
      1: 'Greyjoy',
      2: 'Lannister',
      3: 'Martell',
      4: 'Neutral',
      5: 'Stark',
      6: 'Targaryen',
      7: 'The Night\'s Watch',
      8: 'Tyrell',
    }[_index];
  }
}

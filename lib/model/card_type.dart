class CardType {
  const CardType._(this._index);

  final int _index;

  static const agenda = CardType._(0);
  static const attachment = CardType._(1);
  static const character = CardType._(2);
  static const event = CardType._(3);
  static const location = CardType._(4);
  static const plot = CardType._(5);
  static const title = CardType._(6);
  static const unknown = CardType._(7);

  static const List<CardType> values = <CardType>[
    agenda,
    attachment,
    character,
    event,
    location,
    plot,
    title,
    unknown,
  ];

  static CardType code(String code) {
    switch (code) {
      case 'agenda':
        return CardType.agenda;
      case 'attachment':
        return CardType.attachment;
      case 'character':
        return CardType.character;
      case 'event':
        return CardType.event;
      case 'location':
        return CardType.location;
      case 'plot':
        return CardType.plot;
      case 'title':
        return CardType.title;
      default:
        return CardType.unknown;
    }
  }

  String toString() {
    return const <int, String>{
      0: 'Agenda',
      1: 'Attachment',
      2: 'Character',
      3: 'Event',
      4: 'Location',
      5: 'Plot',
      6: 'Title',
      7: 'Unknown',
    }[_index];
  }
}

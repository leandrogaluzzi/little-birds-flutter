class Type {
  const Type._(this._index);

  final int _index;

  static const agenda = Type._(0);
  static const attachment = Type._(1);
  static const character = Type._(2);
  static const event = Type._(3);
  static const location = Type._(4);
  static const plot = Type._(5);
  static const title = Type._(6);
  static const unknown = Type._(7);

  static const List<Type> values = <Type>[
    agenda,
    attachment,
    character,
    event,
    location,
    plot,
    title,
    unknown,
  ];

  static Type code(String code) {
    switch (code) {
      case 'agenda':
        return Type.agenda;
      case 'attachment':
        return Type.attachment;
      case 'character':
        return Type.character;
      case 'event':
        return Type.event;
      case 'location':
        return Type.location;
      case 'plot':
        return Type.plot;
      case 'title':
        return Type.title;
      default:
        return Type.unknown;
    }
  }

  String toString() {
    return const <int, String>{
      0: 'agenda',
      1: 'attachment',
      2: 'character',
      3: 'event',
      4: 'location',
      5: 'plot',
      6: 'title',
      7: 'unknown',
    }[_index];
  }
}

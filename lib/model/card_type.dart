enum CardType {
  agenda,
  attachment,
  character,
  event,
  location,
  plot,
  title,
  unknown
}

CardType getCardType(String string) {
      switch (string) {
        case 'agenda': return CardType.agenda;
        case 'attachment': return CardType.attachment;
        case 'character': return CardType.character;
        case 'event': return CardType.event;
        case 'location': return CardType.location;
        case 'plot': return CardType.plot;
        case 'title': return CardType.title;
        default: return CardType.unknown;
      }
    }
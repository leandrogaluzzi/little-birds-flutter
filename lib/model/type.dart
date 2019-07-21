enum Type {
  agenda,
  attachment,
  character,
  event,
  location,
  plot,
  title,
  unknown
}

Type getCardType(String string) {
      switch (string) {
        case 'agenda': return Type.agenda;
        case 'attachment': return Type.attachment;
        case 'character': return Type.character;
        case 'event': return Type.event;
        case 'location': return Type.location;
        case 'plot': return Type.plot;
        case 'title': return Type.title;
        default: return Type.unknown;
      }
    }
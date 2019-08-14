import 'package:little_birds/model/slot.dart';
import 'package:little_birds/model/faction.dart';

class ThronesDeck {
  ThronesDeck(
      {this.agendas,
      this.dateCreation,
      this.dateUpdate,
      this.description,
      this.factionCode,
      this.factionName,
      this.id,
      this.name,
      this.slots,
      this.userId});

  final List<String> agendas;
  final String dateCreation;
  final String dateUpdate;
  final String description;
  final String factionCode;
  final String factionName;
  final int id;
  final String name;
  final List<Slot> slots;
  final int userId;

  factory ThronesDeck.fromJson(Map<String, dynamic> json) {
    final jsonAgendas = json['agendas'];
    List<String> agendas = List<String>.from(jsonAgendas);

    final jsonSlots = json['slots'];
    Map<String, int> slots = Map<String, int>.from(jsonSlots);
    List<Slot> deckSlots = [];
    slots.forEach((key, value) {
      Slot deckSlot = Slot(code: key, quantity: value);
      deckSlots.add(deckSlot);
    });

    return ThronesDeck(
        agendas: agendas,
        dateCreation: json['date_creation'],
        dateUpdate: json['date_update'],
        description: json['description'],
        factionCode: json['faction_code'],
        factionName: json['faction_name'],
        id: json['id'],
        name: json['name'],
        slots: deckSlots,
        userId: json['userId']);
  }

  Faction faction() {
    return Faction.code(factionCode);
  }

  String icon() {
    return 'assets/icons/$factionCode.png';
  }

  String link() {
    return 'https://thronesdb.com/decklist/view/$id';
  }
}

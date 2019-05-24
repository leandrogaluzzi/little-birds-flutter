import 'package:little_birds/model/faction.dart';

class Deck {
  Deck(
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
  final Map<String, int> slots;
  final int userId;

  factory Deck.fromJson(Map<String, dynamic> json) {
    final jsonAgendas = json['agendas'];
    List<String> agendas = List<String>.from(jsonAgendas);

    final jsonSlots = json['slots'];
    Map<String, int> slots = Map<String, int>.from(jsonSlots);

    return Deck(
        agendas: agendas,
        dateCreation: json['date_creation'],
        dateUpdate: json['date_update'],
        description: json['description'],
        factionCode: json['faction_code'],
        factionName: json['faction_name'],
        id: json['id'],
        name: json['name'],
        slots: slots,
        userId: json['userId']);
  }

  Faction faction() {
    return getFaction(factionCode);
  }
}

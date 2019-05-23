
import 'package:little_birds/model/card_type.dart';
import 'package:little_birds/model/faction.dart';

class CardItem {
  
  final String packCode;
  final String packName;
  final String typeCode;
  final String typeName;
  final String factionCode;
  final String factionName;
  final String code;
  final String name;
  final int cost; 
  final String text;
  final int quantity;
  final int income;
  final int initiative;
  final int claim;
  final int reserve;
  final int deckLimit;
  final int strength;
  final String traits;
  final String flavor;
  final bool isUnique;
  final bool isLoyal;
  final bool isMilitary;
  final bool isIntrigue;
  final bool isPower;
  final bool isMultiple;
  final String imageUrl;

  CardItem.fromJson(Map<String, dynamic> json)
      : packCode = json['pack_code'],
        packName = json['pack_name'],
        typeCode = json['type_code'],
        typeName = json['type_name'],
        factionCode = json['faction_code'],
        factionName = json['faction_name'],
        code = json['code'],
        name = json['name'],
        cost = json['cost'],
        text = json['text'],
        quantity = json['quantity'],
        income = json['income'],
        initiative = json['initiative'],
        claim = json['claim'],
        reserve = json['reserve'],
        deckLimit = json['deck_limit'],
        strength = json['strength'],
        traits = json['traits'],
        flavor = json['flavor'],
        isUnique = json['is_unique'],
        isLoyal = json['is_loyal'],
        isMilitary = json['is_military'],
        isIntrigue = json['is_intrigue'],
        isPower = json['is_power'],
        isMultiple = json['is_multiple'],
        imageUrl = json['image_url'];

    CardType cardType() {
      switch (typeCode) {
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

    Faction faction() {
      switch (typeCode) {
        case 'baratheon': return Faction.baratheon;
        case 'greyjoy': return Faction.greyjoy;
        case 'lannister': return Faction.lannister;
        case 'martell': return Faction.martell;
        case 'neutral': return Faction.neutral;
        case 'stark': return Faction.stark;
        case 'targaryen': return Faction.targaryen;
        case 'thenightswatch': return Faction.theNightsWatch;
        case 'tyrell': return Faction.tyrell;
        default: return Faction.neutral;
      }
    }

}

class CardItem {
  CardItem({
    this.packCode,
    this.packName,
    this.typeName,
    this.factionName,
    this.code,
    this.name,
    this.cost,
    this.text,
  });

  final String packCode;
  final String packName;
  final String typeName;
  final String factionName;
  final String code;
  final String name;
  final int cost;
  final String text;

  CardItem.fromJson(Map<String, dynamic> json)
      : packCode = json['pack_code'],
        packName = json['pack_name'],
        typeName = json['type_name'],
        factionName = json['faction_name'],
        code = json['code'],
        name = json['name'],
        cost = json['cost'],
        text = json['text'];
}

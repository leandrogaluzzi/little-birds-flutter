class Pack {
  final String name;
  final String code;
  final int position;
  final int cyclePosition;
  final String available;
  final int known;
  final int total;

  Pack.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        code = json['code'],
        position = json['position'],
        cyclePosition = json['cycle_position'],
        available = json['available'],
        known = json['known'],
        total = json['total'];
}

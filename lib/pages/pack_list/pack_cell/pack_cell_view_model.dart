import 'package:flutter/foundation.dart';
import 'package:little_birds/model/thrones_pack.dart';

class PackCellViewModel {
  final ThronesPack pack;

  PackCellViewModel({
    @required this.pack,
  }) : assert(pack != null);

  String name() {
    return pack.name;
  }

  String cycle() {
    return 'Cycle: ${pack.cyclePosition} - ${pack.position}';
  }

  String number() {
    return pack.known < pack.total
        ? '${pack.known}/${pack.total} cards'
        : '${pack.total} cards';
  }
}

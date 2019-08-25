import 'dart:convert';
import 'dart:io';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/model/thrones_pack.dart';
import 'package:little_birds/networking/thrones_api.dart';

class MockThrones extends Thrones {
  @override
  Future<List<ThronesCard>> getCards() async {
    return null;
  }

  @override
  Future<List<ThronesDeck>> getDecks({DateTime date}) async {
    return null;
  }

  @override
  Future<List<ThronesPack>> getPacks() async {
    final file = new File('test/jsons/packs.json');
    final List<dynamic> jsonMap = json.decode(await file.readAsString());
    final List<ThronesPack> packs =
        jsonMap.map((item) => ThronesPack.fromJson(item)).toList();
    return packs;
  }
}

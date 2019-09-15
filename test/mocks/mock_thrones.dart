import 'dart:convert';
import 'dart:io';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/model/thrones_pack.dart';
import 'package:little_birds/api/thrones_service.dart';

class MockThrones implements ThronesService {
  @override
  Future<List<ThronesCard>> cards() async {
    final file = new File('test/jsons/cards.json');
    final List<dynamic> jsonMap = json.decode(await file.readAsString());
    final List<ThronesCard> cards =
        jsonMap.map((item) => ThronesCard.fromJson(item)).toList();
    return cards;
  }

  @override
  Future<List<ThronesPack>> packs() async {
    final file = new File('test/jsons/packs.json');
    final List<dynamic> jsonMap = json.decode(await file.readAsString());
    final List<ThronesPack> packs =
        jsonMap.map((item) => ThronesPack.fromJson(item)).toList();
    return packs;
  }

  @override
  Future<List<ThronesDeck>> decks({DateTime date}) async {
    final file = new File('test/jsons/decks.json');
    final List<dynamic> jsonMap = json.decode(await file.readAsString());
    final List<ThronesDeck> decks =
        jsonMap.map((item) => ThronesDeck.fromJson(item)).toList();
    return decks;
  }
}

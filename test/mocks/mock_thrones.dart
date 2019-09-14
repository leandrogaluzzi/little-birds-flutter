import 'dart:convert';
import 'dart:io';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/model/thrones_pack.dart';
import 'package:little_birds/api/thrones_api.dart';

class MockThrones extends Thrones {
  @override
  Future<List<ThronesCard>> getCards() async {
    final file = new File('test/jsons/cards.json');
    final List<dynamic> jsonMap = json.decode(await file.readAsString());
    final List<ThronesCard> cards =
        jsonMap.map((item) => ThronesCard.fromJson(item)).toList();
    return cards;
  }

  @override
  Future<List<ThronesDeck>> getDecks({DateTime date}) async {
    final file = new File('test/jsons/decks.json');
    final List<dynamic> jsonMap = json.decode(await file.readAsString());
    final List<ThronesDeck> decks =
        jsonMap.map((item) => ThronesDeck.fromJson(item)).toList();
    return decks;
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

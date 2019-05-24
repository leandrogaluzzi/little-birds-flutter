import 'package:flutter/material.dart';
import 'network_provider.dart';
import 'package:little_birds/model/card.dart';
import 'package:little_birds/model/pack.dart';
import 'package:little_birds/model/deck.dart';
import 'dart:convert';

const baseURL = 'https://thronesdb.com';
const _cardsURL = '/api/public/cards/';
const _packsURL = '/api/public/packs/';
const _decksURL = '/api/public/decklists/by_date/';

class ThronesException extends Exception {
  factory ThronesException([var message]) => ThronesException(message);
}

class ThronesAPI {
  ThronesAPI({
    @required this.network,
  }) : assert(network != null);

  final NetworkProvider network;

  Future<List<CardItem>> getCards() async {
    try {
      String response = await network.get(_cardsURL);
      List<dynamic> list = await json.decode(response);
      List<CardItem> cards =
          list.map((item) => CardItem.fromJson(item)).toList();
      return cards;
    } catch (e) {
      throw ThronesException(e);
    }
  }

  Future<List<Pack>> getPacks() async {
    try {
      String response = await network.get(_packsURL);
      List<dynamic> list = await json.decode(response);
      List<Pack> packs =
          list.map((item) => Pack.fromJson(item)).toList();
      return packs;
    } catch (e) {
      throw ThronesException(e);
    }
  }

Future<List<Deck>> getDecks(DateTime date) async {

    String year = date.year.toString();
    String month = date.month.toString().padLeft(2,'0');
    String day = date.day.toString();

    String dateString = '$year-$month-$day';

    String url = _decksURL + dateString;
    print(url);
    try {
      String response = await network.get(url);
      print(response);
      List<dynamic> list = await json.decode(response);
      List<Deck> decks =
          list.map((item) => Deck.fromJson(item)).toList();
      return decks;
    } catch (e) {
      throw ThronesException(e);
    }
  }

}

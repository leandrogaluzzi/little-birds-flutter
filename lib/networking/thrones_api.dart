import 'package:flutter/material.dart';
import 'network_provider.dart';
import 'package:little_birds/model/card.dart';
import 'package:little_birds/model/pack.dart';
import 'dart:convert';

const baseURL = 'https://thronesdb.com';
const _cardsURL = '/api/public/cards/';
const _packsURL = '/api/public/packs/';

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
}

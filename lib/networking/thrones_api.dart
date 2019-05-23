import 'package:flutter/material.dart';
import 'network_provider.dart';
import 'package:little_birds/model/card.dart';
import 'dart:convert';

const baseURL = 'https://thronesdb.com';
const allCardsURL = '/api/public/cards/';

class ThronesException extends Exception {
  factory ThronesException([var message]) => ThronesException(message);
}

class ThronesAPI {
  ThronesAPI({
    @required this.network,
  }) : assert(network != null);

  final NetworkProvider network;

  Future<List<CardItem>> getAllCards() async {
    try {
      String response = await network.get(allCardsURL);
      List<dynamic> list = await json.decode(response);
      List<CardItem> cards =
          list.map((item) => CardItem.fromJson(item)).toList();
      return cards;
    } catch (e) {
      throw ThronesException(e);
    }
  }
}

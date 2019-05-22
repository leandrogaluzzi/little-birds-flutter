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
  });

  final NetworkProvider network;

  Future<List<CardItem>> getAllCards() async {
    final url = allCardsURL;

    try {
      String response = await network.get(url);
      List<dynamic> list = json.decode(response);
      List<CardItem> cards =
          list.map((item) => CardItem.fromJson(item)).toList();
      return cards;
    } on Exception catch (e) {
      print('Exception Thrones API:/n${e.toString()}');
      throw ThronesException(e.toString());
    }
  }
}

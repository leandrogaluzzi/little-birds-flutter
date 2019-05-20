import 'package:flutter/material.dart';
import 'network_provider.dart';
import 'package:little_birds/model/card.dart';

const baseURL = 'https://thronesdb.com';
const allCardsURL = '/api/public/cards/';

class APIException extends Exception {
  factory APIException([var message]) => APIException(message);
}

class API {
  API({
    @required this.network,
  });

  final NetworkProvider network;

  Future<List<CardItem>> getAllCards() async {
    final url = allCardsURL;

    try {
      final response = await network.get(url);
      final List<CardItem> list = [];
      return list;
    } on Exception catch (e) {
      throw APIException(e.toString());
    }
  }
}

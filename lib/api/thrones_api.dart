import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/model/thrones_pack.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/network/network_exception.dart';
import 'package:little_birds/network/network_provider.dart';

const _cardsURL = '/api/public/cards/';
const _packsURL = '/api/public/packs/';
const _decksURL = '/api/public/decklists/by_date/';

class ThronesError extends NetworkError {
  ThronesError([message]) : super(message);
}

abstract class Thrones {
  Future<List<ThronesCard>> getCards();
  Future<List<ThronesPack>> getPacks();
  Future<List<ThronesDeck>> getDecks({DateTime date});
}

class DefaultThrones {
  DefaultThrones({
    @required this.network,
  }) : assert(network != null);

  final NetworkProvider network;

  Future<List<ThronesCard>> getCards() async {
    try {
      String responseString = await network.get(_cardsURL);
      List<dynamic> list = await json.decode(responseString);
      List<ThronesCard> cards =
          list.map((item) => ThronesCard.fromJson(item)).toList();
      return cards;
    } on NetworkError {
      throw ThronesError();
    }
  }

  Future<List<ThronesPack>> getPacks() async {
    try {
      String responseString = await network.get(_packsURL);
      List<dynamic> list = await json.decode(responseString);
      List<ThronesPack> packs =
          list.map((item) => ThronesPack.fromJson(item)).toList();
      return packs;
    } on NetworkError {
      throw ThronesError();
    }
  }

  Future<List<ThronesDeck>> getDecks({DateTime date}) async {
    String year = date.year.toString();
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');

    String dateString = '$year-$month-$day';

    String url = _decksURL + dateString;

    try {
      String responseString = await network.get(url);
      List<dynamic> list = await json.decode(responseString);
      List<ThronesDeck> decks =
          list.map((item) => ThronesDeck.fromJson(item)).toList();
      return decks;
    } on ServerError {
      return [];
    } on NetworkError {
      throw ThronesError();
    }
  }
}

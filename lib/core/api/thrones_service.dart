import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:little_birds/model/auth.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/model/thrones_pack.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/core/network/network_exception.dart';
import 'package:little_birds/core/network/network_provider.dart';
import 'thrones_constants.dart';

class ThronesError extends NetworkError {
  ThronesError([message]) : super(message);
}

abstract class ThronesService {
  Future<List<ThronesCard>> cards();
  Future<List<ThronesPack>> packs();
  Future<List<ThronesDeck>> decks({DateTime date});

  Future<Auth> authToken({String code});
  Future<Auth> refreshToken(String refreshToken);
}

class DefaultThronesService implements ThronesService {
  DefaultThronesService({
    @required this.network,
  }) : assert(network != null);

  final NetworkProvider network;

  Future<List<ThronesCard>> cards() async {
    try {
      String responseString = await network.get(ThronesConstants.cardsURL);
      List<dynamic> list = await json.decode(responseString);
      List<ThronesCard> cards =
          list.map((item) => ThronesCard.fromJson(item)).toList();
      return cards;
    } on NetworkError {
      throw ThronesError();
    }
  }

  Future<List<ThronesPack>> packs() async {
    try {
      String responseString = await network.get(ThronesConstants.packsURL);
      List<dynamic> list = await json.decode(responseString);
      List<ThronesPack> packs =
          list.map((item) => ThronesPack.fromJson(item)).toList();
      return packs;
    } on NetworkError {
      throw ThronesError();
    }
  }

  Future<List<ThronesDeck>> decks({DateTime date}) async {
    String year = date.year.toString();
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');

    String dateString = '$year-$month-$day';

    String url = ThronesConstants.decksURL + dateString;

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

  Future<Auth> authToken({String code}) async {
    String url = ThronesConstants.authURL;
    Map<String, String> parameters = {
      'client_id': ThronesConstants.clientID,
      'client_secret': ThronesConstants.secretID,
      'redirect_uri': ThronesConstants.redirect,
      'code': code,
      'grant_type': 'authorization_code',
    };

    try {
      String responseString = await network.get(url, parameters: parameters);
      dynamic response = json.decode(responseString);
      Auth auth = Auth.fromJson(response);
      return auth;
    } on NetworkError {
      throw ThronesError();
    }
  }

  Future<Auth> refreshToken(String refreshToken) async {
    return null;
  }
}

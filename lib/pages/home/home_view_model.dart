import 'dart:async';

import 'package:flutter/material.dart';
import 'package:little_birds/core/api/thrones_service.dart';
import 'package:little_birds/model/thrones_deck.dart';

class HomeViewModel {
  HomeViewModel({
    @required this.thrones,
  }) : assert(thrones != null);

  final ThronesService thrones;

  final _controller = StreamController<List<ThronesDeck>>();
  Stream<List<ThronesDeck>> get stream => _controller.stream;

  List<ThronesDeck> _decks = [];
  DateTime _date = DateTime.now();

  void dispose() => _controller.close();

  void loadDecks() async {
    _date = DateTime.now();
    _decks = await _getDecks([], _date);
    _sort(deck: _decks);
    _controller.sink.add(_decks);
  }

  void moreDecks() async {
    final newDate = _previousDay(fromDate: _date);
    final newDecks = await _getDecks([], newDate);
    _sort(deck: newDecks);
    _decks.addAll(newDecks);
    _controller.sink.add(_decks);
  }

  void _sort({List<ThronesDeck> deck}) {
    deck.sort((deckA, deckB) {
      return deckB.dateCreation.compareTo(deckA.dateCreation);
    });
  }

  Future<List<ThronesDeck>> _getDecks(
      List<ThronesDeck> decks, DateTime date) async {
    if (decks.length > 10) {
      return decks;
    }
    List<ThronesDeck> newDecks = await thrones.decks(date: date);
    decks.addAll(newDecks);
    DateTime newDate = _previousDay(fromDate: date);
    _date = newDate;
    return _getDecks(decks, newDate);
  }

  DateTime _previousDay({fromDate: DateTime}) {
    return fromDate.add(Duration(days: -1));
  }
}

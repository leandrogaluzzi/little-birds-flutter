import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/api/thrones_service.dart';

class HomeScreenViewModel {
  ThronesService _thronesService = ThronesService();
  DateTime _date = DateTime.now();
  List<ThronesDeck> decks = [];

  Future<void> loadDecks() async {
    _date = DateTime.now();
    decks = await _getDecks([], _date);
    _sort(deck: decks);
    return;
  }

  Future<void> moreDecks() async {
    final newDate = _previousDay(fromDate: _date);
    final newDecks = await _getDecks([], newDate);
    _sort(deck: newDecks);
    decks.addAll(newDecks);
    return;
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
    List<ThronesDeck> newDecks = await _thronesService.getDecks(date);
    decks.addAll(newDecks);
    DateTime newDate = _previousDay(fromDate: date);
    _date = newDate;
    return _getDecks(decks, newDate);
  }

  DateTime _previousDay({fromDate: DateTime}) {
    return fromDate.add(Duration(days: -1));
  }
}

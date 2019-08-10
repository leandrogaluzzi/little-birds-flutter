import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/networking/thrones_service.dart';

class HomeScreenViewModel {
  ThronesService _thronesService = ThronesService();
  DateTime _date = DateTime.now();

  Future<List<ThronesDeck>> decks() async {
    _date = DateTime.now();
    final decks = await _getDecks([], _date);
    return decks;
  }

  Future<List<ThronesDeck>> moreDecks() async {
    final newDate = _previousDay(fromDate: _date);
    final decks = await _getDecks([], newDate);
    return decks;
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

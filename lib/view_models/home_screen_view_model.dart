import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/networking/thrones_service.dart';

class HomeScreenViewModel {
  ThronesService _thronesService = ThronesService();

  Future<List<ThronesDeck>> decks() async {
    final decks = await _getDecks([], DateTime.now());
    return decks;
  }

  Future<List<ThronesDeck>> _getDecks(
      List<ThronesDeck> decks, DateTime date) async {
    if (decks.length > 10) {
      return decks;
    }
    List<ThronesDeck> newDecks = await _thronesService.getDecks(date);
    decks.addAll(newDecks);
    DateTime newDate = date.add(Duration(days: -1));
    return _getDecks(decks, newDate);
  }
}

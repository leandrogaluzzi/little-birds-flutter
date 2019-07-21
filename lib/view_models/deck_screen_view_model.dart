import 'package:little_birds/model/thrones_deck.dart';

class DeckScreenViewModel {
  DeckScreenViewModel({
    this.deck,
  }) : assert(deck != null);

  final ThronesDeck deck;
}

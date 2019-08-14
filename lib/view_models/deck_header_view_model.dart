import 'package:little_birds/model/thrones_deck.dart';

class DeckHeaderViewModel {
  DeckHeaderViewModel({
    this.deck,
  }) : assert(deck != null);

  ThronesDeck deck;

  String icon() {
    return deck.icon();
  }

  String name() {
    return deck.name;
  }

  String info() {
    return '';
  }

  String link() {
    return '';
  }
}

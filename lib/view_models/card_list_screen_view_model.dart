import 'package:flutter/widgets.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/model/thrones_card.dart';

class CardListScreenViewModel {
  CardListScreenViewModel({
    @required this.cardsStore,
  }) : assert(cardsStore != null);

  final CardsStore cardsStore;

  List<ThronesCard> cards({String query}) {
    if (query == null || query == '') {
      return cardsStore.getCardsAlphabetically();
    } else {
      return cardsStore.getCardsWithQuery(query);
    }
  }
}

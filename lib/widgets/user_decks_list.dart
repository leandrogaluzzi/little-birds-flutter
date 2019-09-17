import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_birds/core/cards_store/cards_store_container.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/pages/deck_screen.dart';
import 'package:little_birds/view_models/deck_screen_view_model.dart';
import 'package:little_birds/view_models/user_decks_list_item_view_model.dart';
import 'package:little_birds/widgets/separator.dart';
import 'package:little_birds/widgets/user_decks_list_item.dart';

class UserDecksList extends StatelessWidget {
  UserDecksList({
    Key key,
    @required this.decks,
  })  : assert(decks != null),
        super(key: key);

  final List<ThronesDeck> decks;

  void _onDeckSelected({BuildContext context, ThronesDeck deck}) async {
    final cardsStore = CardsStoreContainer.of(context).cardsStore;
    final viewModel = DeckScreenViewModel(deck: deck, cardsStore: cardsStore);
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return DeckScreen(
            viewModel: viewModel,
          );
        },
      ),
    );
  }

  Widget _listItem({BuildContext context, ThronesDeck deck}) {
    final cardsStore = CardsStoreContainer.of(context).cardsStore;
    final cards = cardsStore.cardsFromSlots(deck.slots);
    final viewModel = UserDecksListItemViewModel(deck: deck, cards: cards);
    return UserDecksListItem(
      viewModel: viewModel,
      onTap: () {
        _onDeckSelected(context: context, deck: deck);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final count = decks.length;
    return ListView.separated(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        final deck = decks[index];
        return _listItem(context: context, deck: deck);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Separator();
      },
    );
  }
}

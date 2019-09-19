import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_birds/core/cards_store/cards_store_container.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/pages/deck/deck_page.dart';
import 'package:little_birds/pages/deck/deck_page_view_model.dart';
import 'package:little_birds/pages/user_decks/user_decks_cell/user_decks_cell.dart';
import 'package:little_birds/pages/user_decks/user_decks_cell/user_decks_cell_view_model.dart';
import 'package:little_birds/widgets/separator.dart';

class UserDecksList extends StatelessWidget {
  UserDecksList({
    Key key,
    @required this.decks,
  })  : assert(decks != null),
        super(key: key);

  final List<ThronesDeck> decks;

  void _onDeckSelected({BuildContext context, ThronesDeck deck}) async {
    final cardsStore = CardsStoreContainer.of(context).cardsStore;
    final viewModel = DeckPageViewModel(deck: deck, cardsStore: cardsStore);
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return DeckPage(
            viewModel: viewModel,
          );
        },
      ),
    );
  }

  Widget _listItem({BuildContext context, ThronesDeck deck}) {
    final cardsStore = CardsStoreContainer.of(context).cardsStore;
    final cards = cardsStore.cardsFromSlots(deck.slots);
    final viewModel = UserDecksCellViewModel(deck: deck, cards: cards);
    return UserDecksCell(
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

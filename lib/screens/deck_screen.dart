import 'package:flutter/material.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/view_models/deck_header_view_model.dart';
import 'package:little_birds/view_models/deck_screen_view_model.dart';
import 'package:little_birds/widgets/card_list_item.dart';
import 'package:little_birds/widgets/deck_header.dart'; //
//import 'package:little_birds/widgets/deck_section_header.dart';

class DeckScreen extends StatelessWidget {
  DeckScreen({
    Key key,
    @required this.viewModel,
  })  : assert(viewModel != null),
        super(key: key);

  final DeckScreenViewModel viewModel;

  Widget _header(BuildContext context) {
    //var cardsStore = CardsStore.of(context);
    final viewModel = DeckHeaderViewModel(
        deck: this.viewModel.deck, cardsStore: this.viewModel.cardsStore);
    return DeckHeader(viewModel: viewModel);
  }

  /*Widget _sectionHeader({Type type}) {
    return DeckSectionHeader(text: viewModel.sectionHeaderTitle(type: type));
  }*/

  /*Widget _sectionList({Type type}) {
    final cards = viewModel.cards(type: type);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final card = cards[index];
          return CardListItem(
            index: index,
            mode: CardListItemMode.deck,
            card: card,
            //count: cards.length,
            onTap: (card) {},
          );
        },
        childCount: cards.length,
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deck'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          _header(context),
          //_sectionHeader(type: Type.agenda),
          //_sectionList(type: Type.agenda),
          //_sectionHeader(type: Type.plot),
          //_sectionList(type: Type.plot),
          //_sectionHeader(type: Type.character),
          //_sectionList(type: Type.character),
          //_sectionHeader(type: Type.attachment),
          //_sectionList(type: Type.attachment),
          //_sectionHeader(type: Type.location),
          //_sectionList(type: Type.location),
          //_sectionHeader(type: Type.event),
          //_sectionList(type: Type.event),
        ],
      ),
    );
  }
}

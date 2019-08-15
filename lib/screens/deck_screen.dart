import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_birds/model/card_quantity.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/screens/card_screen.dart';
import 'package:little_birds/view_models/card_screen_view_model.dart';
import 'package:little_birds/view_models/deck_header_view_model.dart';
import 'package:little_birds/view_models/deck_screen_view_model.dart';
import 'package:little_birds/widgets/card_list_item.dart';
import 'package:little_birds/widgets/deck_footer.dart';
import 'package:little_birds/widgets/deck_header.dart';
import 'package:little_birds/model/type.dart';

class DeckScreen extends StatelessWidget {
  DeckScreen({
    Key key,
    @required this.viewModel,
  })  : assert(viewModel != null),
        super(key: key);

  final DeckScreenViewModel viewModel;

  void _onCardSelected({BuildContext context, card: ThronesCard}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          final viewModel = CardScreenViewModel(card: card);
          return CardScreen(viewModel: viewModel);
        },
      ),
    );
  }

  Widget _header(BuildContext context) {
    final viewModel = DeckHeaderViewModel(
        deck: this.viewModel.deck, cardsStore: this.viewModel.cardsStore);
    return DeckHeader(viewModel: viewModel);
  }

  Widget _link() {
    final url = viewModel.link();
    return DeckFooter(url: url);
  }

  Widget _sectionHeader({Type type}) {
    String text = viewModel.sectionHeaderTitle(type: type);
    return Container(
      height: 35,
      color: Colors.grey[500],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionItem({BuildContext context, CardQuantity card, int index}) {
    return CardListItem(
      index: index,
      mode: CardListItemMode.deck,
      card: card.card,
      count: card.quantity,
      onTap: (card) {
        _onCardSelected(context: context, card: card);
      },
    );
  }

  Widget _sectionList({Type type}) {
    final cards = viewModel.cards(type: type);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == 0) {
            return _sectionHeader(type: type);
          } else {
            int correctIndex = index - 1;
            final card = cards[correctIndex];
            return _sectionItem(
                context: context, card: card, index: correctIndex);
          }
        },
        childCount: cards.length + 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deck'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          _header(context),
          _sectionList(type: Type.agenda),
          _sectionList(type: Type.plot),
          _sectionList(type: Type.character),
          _sectionList(type: Type.attachment),
          _sectionList(type: Type.location),
          _sectionList(type: Type.event),
          _link(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:little_birds/model/card.dart';
import 'package:little_birds/view_models/card_screen_view_model.dart';
import 'package:little_birds/widgets/card_list.dart';

import 'card_screen.dart';

class PackScreen extends StatelessWidget {
  PackScreen({
    Key key,
    @required this.title,
    @required this.cards,
  })  : assert(title != null),
        assert(cards != null),
        super(key: key);

  final List<CardItem> cards;
  final String title;

void _onCardSelected({BuildContext context, card: CardItem}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        final viewModel = CardScreenViewModel(card: card);
        return CardScreen(viewModel: viewModel);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CardList(
        cards: cards,
        onTap: (CardItem card) {
          _onCardSelected(context: context, card: card);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:little_birds/model/thrones_card.dart';
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

  final List<ThronesCard> cards;
  final String title;

void _onCardSelected({BuildContext context, card: ThronesCard}) {
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
        onTap: (ThronesCard card) {
          _onCardSelected(context: context, card: card);
        },
      ),
    );
  }
}

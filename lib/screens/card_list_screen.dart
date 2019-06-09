import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/model/card.dart';
import 'package:little_birds/widgets/card_list.dart';

import 'card_screen.dart';

class CardListScreen extends StatefulWidget {
  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  void _onCardSelected({BuildContext context, card: CardItem}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return CardScreen(
            card: card,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = CardsStore.of(context).getCardsAlphabetically();
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
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

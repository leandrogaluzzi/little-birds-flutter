import 'package:flutter/material.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/widgets/card_list.dart';
import 'package:little_birds/widgets/card_list_item.dart';

class CardListScreen extends StatefulWidget {
  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  @override
  Widget build(BuildContext context) {
    final cards = CardsStore.of(context).getCardsAlphabetically();
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      body: CardList(
        cards: cards,
      ),
    );
  }
}

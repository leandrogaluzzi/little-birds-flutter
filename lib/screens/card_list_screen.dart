import 'package:flutter/material.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/widgets/card_list_cell.dart';

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
      body: ListView.builder(
        itemCount: cards.length,
        itemExtent: 55.0,
        itemBuilder: (BuildContext context, int index) {
          return CardListCell(
            card: cards[index],
            mode: CardListCellMode.list,
          );
        },
      ),
    );
  }
}

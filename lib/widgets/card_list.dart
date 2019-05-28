import 'package:flutter/material.dart';
import 'package:little_birds/model/card.dart';
import 'package:little_birds/screens/card_screen.dart';
import 'package:little_birds/widgets/card_list_item.dart';

class CardList extends StatelessWidget {
  CardList({
    Key key,
    @required this.cards,
  })  : assert(cards != null),
        super(key: key);

  final List<CardItem> cards;

  void _onCardSelected({BuildContext context, card: CardItem}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return CardScreen(
          card: card,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards.length,
      itemExtent: 65.0,
      itemBuilder: (BuildContext context, int index) {
        final card = cards[index];
        return CardListItem(
          card: card,
          mode: CardListItemMode.list,
          onTap: () {
            _onCardSelected(context: context, card: card);
          },
        );
      },
    );
  }
}

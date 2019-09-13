import 'package:flutter/material.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/widgets/card_list_item.dart';
import 'package:little_birds/widgets/separator.dart';

class CardList extends StatelessWidget {
  CardList({
    Key key,
    @required this.cards,
    @required this.onTap,
  })  : assert(cards != null),
        super(key: key);

  final List<ThronesCard> cards;
  final CardCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: cards.length,
      itemBuilder: (BuildContext context, int index) {
        final card = cards[index];
        return CardListItem(
          card: card,
          mode: CardListItemMode.list,
          index: index,
          onTap: onTap,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Separator();
      },
    );
  }
}

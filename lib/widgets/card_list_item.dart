import 'package:flutter/material.dart';
import 'package:little_birds/model/card.dart';
import 'package:little_birds/utils/constants.dart';

enum CardListItemMode {
  list,
  deck,
}

typedef CardCallback = void Function(CardItem card);

class CardListItem extends StatelessWidget {
  CardListItem({
    Key key,
    @required this.card,
    @required this.mode,
    @required this.index,
    @required this.onTap,
  })  : assert(card != null),
        assert(mode != null),
        assert(index != null),
        assert(onTap != null),
        super(key: key);

  final CardItem card;
  final CardListItemMode mode;
  final int index;
  final CardCallback onTap;

  final TextStyle _textStyleName = TextStyle(
    fontSize: 18.0,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  final TextStyle _textStyleQuantity = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  Widget _widgetLeft() {
    return Container(
      width: 55.0,
      child: Center(
        child: Image.asset(
          card.cardIconName(),
        ),
      ),
    );
  }

  Widget _widgetMiddle() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            card.name,
            style: _textStyleName,
          ),
          Text(
            card.typeName,
            style: kTextStyleGreySmall,
          ),
        ],
      ),
    );
  }

  Widget _widgetRight() {
    return Container(
      width: 44.0,
      child: Center(
        child: Text(
          '0',
          style: _textStyleQuantity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index % 2 == 0 ? Colors.white : Colors.grey[200],
      child: RawMaterialButton(
        onPressed: () {
          onTap(card);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _widgetLeft(),
            _widgetMiddle(),
            if (mode == CardListItemMode.deck) _widgetRight(),
          ],
        ),
      ),
    );
  }
}

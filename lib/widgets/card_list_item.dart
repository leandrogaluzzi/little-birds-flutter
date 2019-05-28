import 'package:flutter/material.dart';
import 'package:little_birds/model/card.dart';

enum CardListItemMode {
  list,
  deck,
}

class CardListItem extends StatelessWidget {
  CardListItem({
    Key key,
    @required this.card,
    @required this.mode,
    @required this.onTap,
  })  : assert(card != null),
        assert(mode != null),
        assert(onTap != null),
        super(key: key);

  final CardItem card;
  final CardListItemMode mode;
  final VoidCallback onTap;

  final TextStyle _textStyleName = TextStyle(
    fontSize: 18.0,
    color: Colors.black,
  );

  final TextStyle _textStyleType = TextStyle(
    fontSize: 15.0,
    color: Color.fromRGBO(132, 132, 132, 1.0),
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
            style: _textStyleType,
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
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _widgetLeft(),
          _widgetMiddle(),
          if (mode == CardListItemMode.deck) _widgetRight(),
        ],
      ),
    );
  }
}

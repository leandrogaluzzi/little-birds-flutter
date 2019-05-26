import 'package:flutter/material.dart';
import 'package:little_birds/model/card.dart';

enum CardListCellMode {
  list,
  deck,
}

class CardListCell extends StatelessWidget {
  CardListCell({
    Key key,
    @required this.card,
    @required this.mode,
  })  : assert(card != null),
        assert(mode != null),
        super(key: key);

  final CardItem card;
  final CardListCellMode mode;

  final TextStyle _textStyleName = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
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
        child: Container(
          height: 35.0,
          width: 35.0,
          color: Colors.black,
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _widgetLeft(),
        _widgetMiddle(),
        if (mode == CardListCellMode.deck)
          _widgetRight(),
      ],
    );
  }
}

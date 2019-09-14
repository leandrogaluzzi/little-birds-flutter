import 'package:flutter/material.dart';
import 'package:little_birds/model/card_type.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/utils/constants.dart';

enum CardListItemMode {
  list,
  deck,
}

typedef CardCallback = void Function(ThronesCard card);

class CardListItem extends StatelessWidget {
  CardListItem({
    Key key,
    @required this.card,
    @required this.mode,
    @required this.index,
    @required this.onTap,
    this.count,
  })  : assert(card != null),
        assert(mode != null),
        assert(index != null),
        assert(onTap != null),
        super(key: key);

  final ThronesCard card;
  final CardListItemMode mode;
  final int index;
  final CardCallback onTap;
  final int count;

  final TextStyle _textStyleName = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  final TextStyle _textStyleQuantity = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  final TextStyle kTextStyleType = TextStyle(
    fontSize: 16.0,
    color: kColorGrayText,
  );

  Widget _widgetLeft() {
    return Container(
      width: 55.0,
      child: Center(
        child: Image.asset(
          card.cardIconName(),
          height: 25.0,
        ),
      ),
    );
  }

  String _info() {
    switch (card.cardType()) {
      case CardType.plot:
        return 'Income: ${card.income ?? 0}. Initiative: ${card.initiative ?? 0} Claim: ${card.claim ?? 0}';
        break;
      case CardType.character:
        return 'Cost: ${card.cost ?? 0}. STR: ${card.strength ?? 0}';
        break;
      case CardType.attachment:
      case CardType.location:
      case CardType.event:
        return 'Cost: ${card.cost ?? 0}';
        break;
      default:
        return card.packName;
        break;
    }
  }

  String _subtitle() {
    switch (mode) {
      case CardListItemMode.deck:
        return _info();
        break;
      default:
        return '${card.typeName} - ${card.packName}';
        break;
    }
  }

  Widget _widgetMiddle() {
    final subtitle = _subtitle();
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FittedBox(
            child: Text(
              card.name,
              style: _textStyleName,
            ),
          ),
          FittedBox(
            child: Text(
              subtitle,
              style: kTextStyleType,
            ),
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
          '$count',
          style: _textStyleQuantity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      color: Colors.white,
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

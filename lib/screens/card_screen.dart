import 'package:flutter/material.dart';
import 'package:little_birds/model/card.dart';
import 'package:little_birds/utils/constants.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:little_birds/model/card_type.dart';

class CardScreen extends StatelessWidget {
  CardScreen({
    Key key,
    @required this.card,
  })  : assert(card != null),
        super(key: key);

  final CardItem card;

  String _getInfoString() {
    switch (card.cardType()) {
      case CardType.plot:
        return '${card.typeName}. Income: ${card.income ?? 0}. Initiative: ${card.initiative ?? 0} Claim: ${card.claim ?? 0}. Reserve: ${card.reserve ?? 0}. Plot deck limit: ${card.deckLimit ?? 0}.';
        break;
      case CardType.character:
        return '${card.typeName}. Cost: ${card.cost ?? 0}. STR: ${card.strength ?? 0}';
        break;
      case CardType.attachment:
      case CardType.location:
      case CardType.event:
        return '${card.typeName}. Cost: ${card.cost ?? 0}';
        break;
      default:
        return card.typeName;
        break;
    }
  }

  String _getPackString() {
    return '${card.packName} #${card.code.substring(card.code.length - 2)}';
  }

  Widget _widgetImage() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Image.network(card.imageUrl),
      ),
    );
  }

  Widget _widgetHouse() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
              child: Image.asset(
                card.cardIconName(),
              ),
            ),
          ),
          Text(
            card.factionName,
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetInfo() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          _getInfoString(),
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
      ),
    );
  }

  Widget _widgetTraits() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          card.traits,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17.0,
            color: kColorGrayText,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _widgetText() {
    return Container(
      child: Html(
        data: '<center>${card.text}</center>',
        padding: EdgeInsets.symmetric(vertical: 0.0),
        defaultTextStyle: TextStyle(
          fontSize: 17.0,
        ),
      ),
    );
  }

  Widget _widgetIcons() {
    return Center(
      child: Container(
        height: 70.0,
        width: 250.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Opacity(
                opacity: card.isMilitary ? 1.0 : 0.1,
                child: Image.asset('assets/icons/military.png'),
              ),
              Opacity(
                opacity: card.isIntrigue ? 1.0 : 0.1,
                child: Image.asset('assets/icons/intrigue.png'),
              ),
              Opacity(
                opacity: card.isPower ? 1.0 : 0.1,
                child: Image.asset('assets/icons/power.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _widgetFlavor() {
    return Container(
      child: Html(
        data: '<center>${card.flavor}</center>',
        padding: EdgeInsets.all(0.0),
        defaultTextStyle: TextStyle(
          fontSize: 15.0,
          fontStyle: FontStyle.italic,
          color: kColorGrayText,
        ),
      ),
    );
  }

  Widget _widgetPack() {
    return Container(
      height: 45.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          _getPackString(),
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(card.name),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (card.imageUrl != null) _widgetImage(),
              _widgetHouse(),
              _widgetInfo(),
              if (card.traits.isNotEmpty) _widgetTraits(),
              _widgetText(),
              if (card.cardType() == CardType.character) _widgetIcons(),
              if (card.flavor != null) _widgetFlavor(),
              _widgetPack(),
            ],
          ),
        ));
  }
}

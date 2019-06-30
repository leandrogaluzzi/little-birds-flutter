import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/model/card.dart';
import 'package:little_birds/view_models/card_screen_view_model.dart';
import 'package:little_birds/widgets/card_list.dart';

import 'card_screen.dart';

class CardListScreen extends StatefulWidget {
  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  bool _isSearching = false;

  void _onCardSelected({BuildContext context, card: CardItem}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          final viewModel = CardScreenViewModel(card: card);
          return CardScreen(viewModel: viewModel);
        },
      ),
    );
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  Widget _getButtonSearch() {
    return IconButton(
      icon: Icon(Icons.search, color: Colors.white),
      onPressed: () {
        _toggleSearch();
      },
    );
  }

  Widget _getButtonFilter() {
    return IconButton(
      icon: Icon(Icons.filter_list, color: Colors.white),
      onPressed: () {

      },
    );
  }

  Widget _getButtonCancelSearch() {
    return IconButton(
      icon: Icon(Icons.close, color: Colors.white),
      onPressed: () {
        _toggleSearch();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = CardsStore.of(context).getCardsAlphabetically();
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching ? _getButtonCancelSearch() : null,
        title: _isSearching ? null : Text('Cards'),
        actions: <Widget>[
          if (!_isSearching)
            _getButtonSearch(),
          _getButtonFilter(),
        ],
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

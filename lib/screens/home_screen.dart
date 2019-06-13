import 'package:flutter/material.dart';
import 'package:little_birds/networking/thrones_service.dart';
import 'package:little_birds/model/deck.dart';
import 'package:little_birds/screens/deck_screen.dart';
import 'package:little_birds/view_models/home_list_item_view_model.dart';
import 'package:little_birds/widgets/home_list_item.dart';

import '../cards_store.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Deck>> _decks;
  ThronesService _thronesService = ThronesService();

  @override
  void initState() {
    _decks = _buildDecks();
    super.initState();
  }

  Future<List<Deck>> _buildDecks() async {
    final decks = await _getDecks([], DateTime.now().add(Duration(days: -1)));
    return decks;
  }

  Future<List<Deck>> _getDecks(List<Deck> decks, DateTime date) async {
    if (decks.length > 10) {
      return decks;
    }
    List<Deck> newDecks = await _thronesService.getDecks(date);
    decks.addAll(newDecks);
    DateTime newDate = date.add(Duration(days: -1));
    return _getDecks(decks, newDate);
  }
  
  void _onDeckSelected({BuildContext context, Deck deck}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return DeckScreen(
          deck: deck,
        );
      }),
    );
  }

  Widget _widgetLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _widgetError({Error error}) {
    print(error);
    return Container(color: Colors.red);
  }

  Widget _widgetList({@required List<Deck> decks}) {
    return RefreshIndicator(
      onRefresh: () => _buildDecks(),
      child: ListView.builder(
        itemCount: decks.length,
        itemBuilder: (BuildContext context, int index) {
          final cards = CardsStore.of(context).getCardsAlphabetically();
          final deck = decks[index];
          final viewModel = HomeListItemViewModel(deck: deck, cards: cards);
          return HomeListItem(
              viewModel: viewModel,
              onTap: () {
                _onDeckSelected(deck: deck);
              });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: FutureBuilder<List<Deck>>(
        future: _decks,
        builder: (BuildContext context, AsyncSnapshot<List<Deck>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return _widgetLoading();
            case ConnectionState.done:
              if (snapshot.hasError) return _widgetError(error: snapshot.error);
              return _widgetList(decks: snapshot.data);
          }
          return null;
        },
      ),
    );
  }
}

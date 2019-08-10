import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_birds/networking/thrones_service.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/screens/deck_screen.dart';
import 'package:little_birds/view_models/deck_screen_view_model.dart';
import 'package:little_birds/view_models/home_list_item_view_model.dart';
import 'package:little_birds/view_models/home_screen_view_model.dart';
import 'package:little_birds/widgets/home_list_item.dart';
import 'package:little_birds/cards_store.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    @required this.viewModel,
  }) : assert(viewModel != null);

  final HomeScreenViewModel viewModel;

  @override
  _HomeScreenState createState() => _HomeScreenState(viewModel: viewModel);
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState({
    @required this.viewModel,
  }) : assert(viewModel != null);

  final HomeScreenViewModel viewModel;
  Future<List<ThronesDeck>> _decks;
  ScrollController _controller;

  @override
  void initState() {
    _decks = viewModel.decks();
    _startScrollController();
    super.initState();
  }

  void _startScrollController() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        print("reach the bottom");
      });
    }
  }

  void _onDeckSelected({BuildContext context, ThronesDeck deck}) {
    final cardsStore = CardsStore.of(context);
    final viewModel = DeckScreenViewModel(deck: deck, cardsStore: cardsStore);
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return DeckScreen(
            viewModel: viewModel,
          );
        },
      ),
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

  Widget _widgetList({@required List<ThronesDeck> decks}) {
    return RefreshIndicator(
      onRefresh: () => viewModel.decks(),
      child: ListView.builder(
        controller: _controller,
        itemCount: decks.length,
        itemBuilder: (BuildContext context, int index) {
          final cards = CardsStore.of(context).getCardsAlphabetically();
          final deck = decks[index];
          final viewModel = HomeListItemViewModel(deck: deck, cards: cards);
          return HomeListItem(
            viewModel: viewModel,
            index: index,
            onTap: () {
              _onDeckSelected(context: context, deck: deck);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Little Birds'),
      ),
      body: FutureBuilder<List<ThronesDeck>>(
        future: _decks,
        builder:
            (BuildContext context, AsyncSnapshot<List<ThronesDeck>> snapshot) {
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

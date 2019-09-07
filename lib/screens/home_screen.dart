import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_birds/analytics/analytics.dart';
import 'package:little_birds/analytics/analytics_event.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/screens/deck_screen.dart';
import 'package:little_birds/screens/request_error_screen.dart';
import 'package:little_birds/utils/keys.dart';
import 'package:little_birds/view_models/deck_screen_view_model.dart';
import 'package:little_birds/view_models/home_list_item_view_model.dart';
import 'package:little_birds/view_models/home_screen_view_model.dart';
import 'package:little_birds/widgets/home_list_item.dart';
import 'package:little_birds/cards_store.dart';

double _heightLoading = 75;

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key key,
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
  Future<void> _decksFuture;
  ScrollController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    _decksFuture = viewModel.loadDecks();
    _startScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _startScrollController() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_isLoading) {
      return;
    }
    if (_controller.offset >=
            _controller.position.maxScrollExtent - _heightLoading &&
        !_controller.position.outOfRange) {
      _loadMoreDecks();
    }
  }

  void _loadMoreDecks() async {
    Analytics.track(event: AnalyticsEvent.home_load_more);
    _isLoading = true;
    await viewModel.moreDecks();
    setState(() {});
  }

  Future<void> _refreshDecks() async {
    Analytics.track(event: AnalyticsEvent.home_refresh);
    await viewModel.loadDecks();
    setState(() {});
  }

  void _onDeckSelected({BuildContext context, ThronesDeck deck}) {
    Analytics.trackDeck(deck);
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
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    );
  }

  Widget _widgetError({Error error}) {
    return RequestErrorScreen(
      title: 'Error loading decks',
      onPressed: () {
        setState(() {
          _decksFuture = viewModel.loadDecks();
        });
      },
    );
  }

  Widget _widgetListItem({BuildContext context, int index}) {
    final cards = CardsStore.of(context).getCardsAlphabetically();
    final deck = this.viewModel.decks[index];
    final viewModel = HomeListItemViewModel(deck: deck, cards: cards);
    return HomeListItem(
      viewModel: viewModel,
      index: index,
      onTap: () {
        _onDeckSelected(context: context, deck: deck);
      },
    );
  }

  Widget _widgetLoadingMore({int index}) {
    return Container(
      height: _heightLoading,
      color: index % 2 == 0 ? Colors.white : Colors.grey[200],
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
  }

  Widget _widgetList() {
    final count = viewModel.decks.length;
    return RefreshIndicator(
      onRefresh: _refreshDecks,
      child: ListView.builder(
        controller: _controller,
        itemCount: count + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == count) {
            return _widgetLoadingMore(index: index);
          } else {
            return _widgetListItem(context: context, index: index);
          }
        },
      ),
    );
  }

  Widget _title() {
    return Image.asset('assets/icons/littlebirds.png');
  }

  @override
  Widget build(BuildContext context) {
    _isLoading = false;
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: FutureBuilder<void>(
        future: _decksFuture,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return _widgetLoading();
            case ConnectionState.done:
              if (snapshot.hasError) return _widgetError(error: snapshot.error);
              return _widgetList();
          }
          return null;
        },
      ),
    );
  }
}

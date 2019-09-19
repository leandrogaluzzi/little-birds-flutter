import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:little_birds/core/ads/ads.dart';
import 'package:little_birds/core/analytics/analytics.dart';
import 'package:little_birds/core/analytics/analytics_event.dart';
import 'package:little_birds/core/analytics/analytics_screen.dart';
import 'package:little_birds/core/cards_store/cards_store_container.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/pages/deck/deck_page.dart';
import 'package:little_birds/pages/deck/deck_page_view_model.dart';
import 'package:little_birds/pages/home/home_cell/home_cell.dart';
import 'package:little_birds/pages/home/home_cell/home_cell_view_model.dart';
import 'package:little_birds/pages/home/home_view_model.dart';
import 'package:little_birds/pages/request_error_page.dart';
import 'package:little_birds/utils/keys.dart';
import 'package:little_birds/widgets/separator.dart';

double _heightLoading = 75;

class HomePage extends StatefulWidget with AnalyticsScreen {
  final HomeViewModel viewModel;

  HomePage({
    Key key,
    this.viewModel,
  })  : assert(viewModel != null),
        super(key: key);

  @override
  String get screenName => 'Home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _startScrollController();
    widget.viewModel.loadDecks();
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
    widget.viewModel.moreDecks();
  }

  Future<void> _refreshDecks() async {
    Analytics.track(event: AnalyticsEvent.home_refresh);
    widget.viewModel.loadDecks();
  }

  void _onDeckSelected({BuildContext context, ThronesDeck deck}) async {
    Analytics.trackDeck(deck);
    final cardsStore = CardsStoreContainer.of(context).cardsStore;
    final viewModel = DeckPageViewModel(deck: deck, cardsStore: cardsStore);
    await Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return DeckPage(
            viewModel: viewModel,
          );
        },
      ),
    );
    Ads.showInterestial(context);
  }

  Widget _widgetLoading() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    );
  }

  Widget _widgetError({Error error}) {
    return RequestErrorPage(
      title: 'Error loading decks',
      onPressed: () {
        setState(() {});
      },
    );
  }

  Widget _widgetListItem({BuildContext context, ThronesDeck deck}) {
    final cardsStore = CardsStoreContainer.of(context).cardsStore;
    final cards = cardsStore.cardsFromSlots(deck.slots);
    final viewModel = HomeCellViewModel(deck: deck, cards: cards);
    return HomeCell(
      key: Key(deck.faction().toCode()),
      viewModel: viewModel,
      onTap: () {
        _onDeckSelected(context: context, deck: deck);
      },
    );
  }

  Widget _widgetLoadingMore({int index}) {
    return Container(
      height: _heightLoading,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
  }

  Widget _widgetList({List<ThronesDeck> decks}) {
    final count = decks.length;
    return RefreshIndicator(
      onRefresh: _refreshDecks,
      child: ListView.separated(
        key: Keys.homeList,
        controller: _controller,
        itemCount: count + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == count) {
            return _widgetLoadingMore(index: index);
          } else {
            final deck = decks[index];
            return _widgetListItem(context: context, deck: deck);
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return Separator();
        },
      ),
    );
  }

  Widget _title() {
    return Image.asset('assets/icons/littlebirds.png');
  }

  Widget _body() {
    return StreamBuilder<List<ThronesDeck>>(
      stream: widget.viewModel.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return _widgetLoading();
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) return _widgetError(error: snapshot.error);
            return _widgetList(decks: snapshot.data);
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _isLoading = false;
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: _body(),
    );
  }
}

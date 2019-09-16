import 'package:flutter/material.dart';
import 'package:little_birds/core/cards_store.dart';
import 'package:little_birds/core/api/thrones_service.dart';
import 'package:little_birds/core/secure_storage/secure_storage.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/screens/request_error_screen.dart';
import 'package:little_birds/screens/request_loading_screen.dart';
import 'package:little_birds/core/services.dart';
import 'package:little_birds/widgets/tab_bar_component.dart';

class MainScreen extends StatefulWidget {
  MainScreen({
    Key key,
    @required this.thronesService,
  })  : assert(thronesService != null),
        super(key: key);

  final ThronesService thronesService;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future _cards;

  Widget _widgetLoading() {
    return RequestLoadingScreen(
      title: 'Loading cards ...',
    );
  }

  Widget _widgetError({Error error}) {
    return RequestErrorScreen(
      title: 'Error loading cards.',
      onPressed: () {
        setState(() {
          _cards = widget.thronesService.cards();
        });
      },
    );
  }

  Widget _widgetTabs({List<ThronesCard> cards}) {
    final cardsStore = CardsStore(cards: cards);
    final secureStorage = SecureStorage();
    final tabs = TabBarComponent();
    return Services(
      thronesService: widget.thronesService,
      cardsStore: cardsStore,
      secureStorage: secureStorage,
      child: tabs,
    );
  }

  @override
  Widget build(BuildContext context) {
    _cards = widget.thronesService.cards();
    return FutureBuilder<List<ThronesCard>>(
      future: _cards,
      builder:
          (BuildContext context, AsyncSnapshot<List<ThronesCard>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return _widgetLoading();
          case ConnectionState.done:
            if (snapshot.hasError) return _widgetError(error: snapshot.error);
            return _widgetTabs(cards: snapshot.data);
        }
        return null;
      },
    );
  }
}

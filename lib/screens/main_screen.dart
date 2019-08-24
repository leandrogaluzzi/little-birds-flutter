import 'package:flutter/material.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/networking/thrones_service.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/screens/request_error_screen.dart';
import 'package:little_birds/screens/request_loading_screen.dart';
import 'package:little_birds/utils/constants.dart';
import 'package:little_birds/widgets/tab_bar_component.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ThronesService _thronesService = ThronesService();
  Future _cards;

  @override
  void initState() {
    _cards = _thronesService.getCards();
    super.initState();
  }

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
          _cards = _thronesService.getCards();
        });
      },
    );
  }

  Widget _widgetTabs({@required List<ThronesCard> cards}) {
    return CardsStore(
      cards: cards,
      child: TabBarComponent(),
    );
  }

  @override
  Widget build(BuildContext context) {
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

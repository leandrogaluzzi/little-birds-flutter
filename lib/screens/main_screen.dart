import 'package:flutter/material.dart';
import 'package:little_birds/api/thrones_api.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/screens/request_error_screen.dart';
import 'package:little_birds/screens/request_loading_screen.dart';
import 'package:little_birds/widgets/tab_bar_component.dart';

class MainScreen extends StatefulWidget {
  MainScreen({
    @required this.thrones,
  }) : assert(thrones != null);

  final Thrones thrones;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future _cards;

  @override
  void initState() {
    _cards = widget.thrones.cards();
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
          _cards = widget.thrones.cards();
        });
      },
    );
  }

  Widget _widgetTabs({@required List<ThronesCard> cards}) {
    return CardsStore(
      cards: cards,
      child: TabBarComponent(
        thrones: widget.thrones,
      ),
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

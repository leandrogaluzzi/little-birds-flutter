import 'package:flutter/material.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/networking/thrones_service.dart';
import 'package:little_birds/model/card.dart';
import 'package:little_birds/widgets/tab_bar_widget.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future _cards;

  @override
  void initState() {
    ThronesService thronesService = ThronesService();
    _cards = thronesService.getCards();
    super.initState();
  }

  Widget _widgetLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _widgetError({Error error}) {
    return Container(color: Colors.red);
  }

  Widget _widgetTabs({ @required List<CardItem> cards}) {
    return CardsStore(
      cards: cards,
      child: TabBarWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CardItem>>(
      future: _cards,
      builder: (BuildContext context, AsyncSnapshot<List<CardItem>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return _widgetLoading();
          case ConnectionState.done:
            if (snapshot.hasError) 
              return _widgetError(error: snapshot.error); 
            return _widgetTabs(cards: snapshot.data);
        }
        return null;
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/networking/thrones_service.dart';
import 'package:little_birds/model/thrones_card.dart';
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
    return Scaffold(
      body: Container(
        color: kColorYellowLittleBirds,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Loading cards ...',
              key: Key('loading'),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            Container(
              height: 100,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetError({Error error}) {
    return Scaffold(
      body: Container(
        color: kColorYellowLittleBirds,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Error loading cards.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            Container(height: 12.0),
            Text(
              'Please, check your internet connection',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            Container(
              height: 100,
              child: Center(
                child: RaisedButton(
                  color: Colors.grey[300],
                  child:
                      Text('Try again', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      _cards = _thronesService.getCards();
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
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

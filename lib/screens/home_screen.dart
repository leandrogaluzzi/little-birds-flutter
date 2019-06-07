import 'package:flutter/material.dart';
import 'package:little_birds/networking/thrones_service.dart';
import 'package:little_birds/model/deck.dart';

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
    final decks = await _getDecks([], DateTime.now());
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

  Widget _widgetLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _widgetError({Error error}) {
    return Container(color: Colors.red);
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
              return Container(color: Colors.red);
          }
          return null;
        },
      ),
    );
  }
}

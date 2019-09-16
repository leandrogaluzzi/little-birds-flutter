import 'package:flutter/material.dart';
import 'package:little_birds/core/api/thrones_service.dart';
import 'package:little_birds/model/auth.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/screens/request_error_screen.dart';
import 'package:little_birds/widgets/separator.dart';

class UserDecksList extends StatefulWidget {
  UserDecksList({
    Key key,
    @required this.auth,
    @required this.thrones,
  })  : assert(thrones != null),
        assert(auth != null),
        super(key: key);

  final ThronesService thrones;
  final Auth auth;

  @override
  _UserDecksListState createState() => _UserDecksListState();
}

class _UserDecksListState extends State<UserDecksList> {
  Future _userDecks;

  Future<void> _refresh() async {
    //await viewModel.
    //setState(() {});
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    );
  }

  Widget _error({Error error}) {
    return RequestErrorScreen(
      title: 'Error loading decks',
      onPressed: () {
        setState(() {
          _userDecks =
              widget.thrones.userDecks(accessToken: widget.auth.accessToken);
        });
      },
    );
  }

  Widget _listItem({ThronesDeck deck}) {
    return Container(
      height: 100,
      color: Colors.green,
      child: Center(
        child: Text(deck.name),
      ),
    );
  }

  Widget _list({List<ThronesDeck> decks}) {
    final count = decks.length;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.separated(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          final deck = decks[index];
          return _listItem(deck: deck);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Separator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _userDecks = widget.thrones.userDecks(accessToken: widget.auth.accessToken);
    return FutureBuilder<List<ThronesDeck>>(
      future: _userDecks,
      builder:
          (BuildContext context, AsyncSnapshot<List<ThronesDeck>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return _loading();
          case ConnectionState.done:
            if (snapshot.hasError) return _error(error: snapshot.error);
            return _list(decks: snapshot.data);
        }
        return null;
      },
    );
  }
}

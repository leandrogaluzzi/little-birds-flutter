import 'dart:async';
import 'package:flutter/material.dart';
import 'package:little_birds/core/api/thrones_constants.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/screens/request_error_screen.dart';
import 'package:little_birds/view_models/user_decks_view_model.dart';
import 'package:little_birds/widgets/separator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';

class UserDecksScreen extends StatefulWidget {
  UserDecksScreen({
    Key key,
    @required this.viewModel,
  })  : assert(viewModel != null),
        super(key: key);

  final UserDecksViewModel viewModel;

  @override
  _UserDecksScreenState createState() => _UserDecksScreenState();
}

class _UserDecksScreenState extends State<UserDecksScreen> {
  StreamSubscription _sub;
  Future _userDecks;

  @override
  void initState() {
    super.initState();

    _sub = getUriLinksStream().listen((Uri uri) {
      _handleUri(uri);
    }, onError: (error) {
      _handleError(error);
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  _openAuth() async {
    final url = ThronesConstants.codeURL();

    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    }
  }

  _handleUri(Uri uri) async {
    await widget.viewModel.auth(uri: uri);
    setState(() {});
  }

  _handleError(dynamic error) {
    print(error);
  }

  Future<void> _refresh() async {
    //await viewModel.
    //setState(() {});
  }

  Widget _login() {
    return Center(
      child: RawMaterialButton(
        child: Text('Login'),
        onPressed: () {
          _openAuth();
        },
      ),
    );
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
      title: 'Error loading packs',
      onPressed: () {
        setState(() {
          _userDecks = widget.viewModel.userDecks();
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

  Widget _futureBuilder() {
    _userDecks = widget.viewModel.userDecks();
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

  Widget _body() {
    return widget.viewModel.isAuthenticated() ? _futureBuilder() : _login();
  }

  Widget _add(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add_circle_outline),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Decks'),
        actions: <Widget>[_add(context)],
      ),
      body: _body(),
    );
  }
}

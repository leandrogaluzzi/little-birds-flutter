import 'dart:async';
import 'package:flutter/material.dart';
import 'package:little_birds/core/api/thrones_constants.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/screens/request_error_screen.dart';
import 'package:little_birds/view_models/user_decks_view_model.dart';
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

  Widget _list({List<ThronesDeck> decks}) {
    return Container(color: Colors.blue);
  }

  Widget _widgetUserDecks() {
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

  _body() {
    return widget.viewModel.isAuthenticated() ? _widgetUserDecks() : _login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Decks'),
      ),
      body: _body(),
    );
  }
}

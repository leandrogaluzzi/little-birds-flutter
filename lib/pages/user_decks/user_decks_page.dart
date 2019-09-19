import 'dart:async';
import 'package:flutter/material.dart';
import 'package:little_birds/core/api/thrones_constants.dart';
import 'package:little_birds/core/api/thrones_error.dart';
import 'package:little_birds/model/auth.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/pages/request_error_page.dart';
import 'package:little_birds/pages/user_decks/user_decks_list/user_decks_list.dart';
import 'package:little_birds/pages/user_decks/user_decks_page_view_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';

enum UserDecksState {
  loading,
  errorList,
  errorLogin,
  list,
  login,
}

class UserDecksPage extends StatefulWidget {
  UserDecksPage({
    Key key,
    @required this.viewModel,
  })  : assert(viewModel != null),
        super(key: key);

  final UserDecksPageViewModel viewModel;

  @override
  _UserDecksPageState createState() => _UserDecksPageState();
}

class _UserDecksPageState extends State<UserDecksPage> {
  StreamSubscription _sub;
  UserDecksState _state = UserDecksState.loading;
  List<ThronesDeck> decks = [];
  Auth _auth;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  _checkAuthentication() async {
    _auth = await widget.viewModel.getAuth();
    if (_auth == null) {
      _setLoginState();
    } else {
      _loadUserDecks();
    }
  }

  _loadUserDecks() async {
    try {
      decks = await widget.viewModel.userDecks();
      setState(() {
        _state = UserDecksState.list;
      });
    } on ThronesAuthorizationError {
      _refreshAuth();
    } on ThronesError {
      setState(() {
        _state = UserDecksState.errorList;
      });
    }
  }

  _refreshAuth() async {
    try {
      await widget.viewModel.refreshAuth();
      _loadUserDecks();
    } on ThronesError {
      _setLoginState();
    }
  }

  _openAuth() async {
    final url = ThronesConstants.codeURL();

    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    }
  }

  _handleUri(Uri uri) async {
    await widget.viewModel.auth(uri: uri);
    _loadUserDecks();
  }

  _handleError(dynamic error) {
    setState(() {
      _state = UserDecksState.errorLogin;
    });
  }

  _setLoginState() {
    _sub = getUriLinksStream().listen((Uri uri) {
      _handleUri(uri);
    }, onError: (error) {
      _handleError(error);
    });
    setState(() {
      _state = UserDecksState.login;
    });
  }

  Future<void> _refreshDecks() async {
    _loadUserDecks();
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

  Widget _errorList() {
    return RequestErrorPage(
      title: 'Error loading decks',
      onPressed: () {
        _loadUserDecks();
      },
    );
  }

  Widget _errorLogin() {
    return RequestErrorPage(
      title: 'Error logging in',
      onPressed: () {
        setState(() {
          _state = UserDecksState.login;
        });
      },
    );
  }

  Widget _list() {
    return RefreshIndicator(
      child: UserDecksList(decks: decks),
      onRefresh: _refreshDecks,
    );
  }

  Widget _add(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add_circle_outline),
      onPressed: () {},
    );
  }

  Widget _body() {
    switch (_state) {
      case UserDecksState.login:
        return _login();
        break;
      case UserDecksState.list:
        return _list();
        break;
      case UserDecksState.errorList:
        return _errorList();
        break;
      case UserDecksState.errorLogin:
        return _errorLogin();
        break;
      case UserDecksState.loading:
      default:
        return _loading();
    }
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

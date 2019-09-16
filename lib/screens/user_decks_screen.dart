import 'dart:async';
import 'package:flutter/material.dart';
import 'package:little_birds/core/api/thrones_constants.dart';
import 'package:little_birds/model/auth.dart';
import 'package:little_birds/view_models/user_decks_view_model.dart';
import 'package:little_birds/widgets/user_decks_list.dart';
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
  bool _isLoading = true;
  bool _isAuthenticated = false;
  Auth _auth;

  @override
  void initState() {
    super.initState();

    _sub = getUriLinksStream().listen((Uri uri) {
      _handleUri(uri);
    }, onError: (error) {
      _handleError(error);
    });

    _checkAuthentication();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  _checkAuthentication() async {
    _auth = await widget.viewModel.getAuth();
    setState(() {
      _isLoading = false;
      _isAuthenticated = _auth != null;
    });
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

  Widget _list({Auth auth}) {
    return UserDecksList(
      thrones: widget.viewModel.thrones,
      auth: auth,
    );
  }

  Widget _body() {
    return _isAuthenticated ? _list(auth: _auth) : _login();
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
      body: _isLoading ? _loading() : _body(),
    );
  }
}

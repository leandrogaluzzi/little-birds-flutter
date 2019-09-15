import 'dart:async';
import 'package:flutter/material.dart';
import 'package:little_birds/core/api/thrones_constants.dart';
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
    String code = uri.queryParameters['code'];
    print(code);
    await widget.viewModel.auth(code: code);
  }

  _handleError(dynamic error) {
    print(error);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Decks'),
      ),
      body: Center(
        child: RawMaterialButton(
            child: Text('Login'),
            onPressed: () {
              _openAuth();
            }),
      ),
    );
  }
}

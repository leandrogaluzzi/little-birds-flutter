import 'dart:async';
import 'package:flutter/material.dart';
import 'package:little_birds/api/thrones_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();

    _sub = getUriLinksStream().listen((Uri uri) {
      String code = uri.queryParameters['code'];
      print(code);
      // Parse the link and warn the user, if it is not correct
    }, onError: (err) {
      print(err);
      // Handle exception by warning the user their action did not succeed
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  _openAuth() async {
    final url = ThronesConstants.authURL();

    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    }
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

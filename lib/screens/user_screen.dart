import 'package:flutter/material.dart';
import 'package:little_birds/api/thrones_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  _openAuth() async {
    final url = ThronesConstants.authURL();

    if (await canLaunch(url)) {
      await launch(url);
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

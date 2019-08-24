import 'package:flutter/material.dart';
import 'package:little_birds/utils/keys.dart';

class RequestLoadingScreen extends StatelessWidget {
  const RequestLoadingScreen({
    Key key,
    this.title,
    this.backgroundColor,
  })  : assert(title != null),
        super(key: key);

  final String title;
  final Color backgroundColor;

  Widget _text() {
    return Text(
      title,
      key: Keys.loading,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18),
    );
  }

  Widget _progress() {
    return Container(
      height: 100,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _text(),
            _progress(),
          ],
        ),
      ),
    );
  }
}

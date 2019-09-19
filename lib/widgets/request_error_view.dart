import 'package:flutter/material.dart';

class RequestErrorView extends StatelessWidget {
  const RequestErrorView({
    Key key,
    this.title,
    this.onPressed,
  })  : assert(title != null),
        assert(onPressed != null),
        super(key: key);

  final String title;
  final VoidCallback onPressed;

  Widget _title() {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18),
    );
  }

  Widget _text() {
    return Text(
      'Please, check your internet connection',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14),
    );
  }

  Widget _button() {
    return Container(
      height: 100,
      child: Center(
        child: RaisedButton(
          color: Colors.grey[300],
          child: Text(
            'Try again',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _title(),
            Container(height: 12.0),
            _text(),
            _button()
          ],
        ),
      ),
    );
  }
}

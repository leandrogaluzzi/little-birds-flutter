import 'package:flutter/material.dart';

class CardListScreen extends StatefulWidget {
  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
    );
  }
}

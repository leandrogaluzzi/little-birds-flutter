import 'package:flutter/material.dart';

class PackListScreen extends StatefulWidget {
  @override
  _PackListScreenState createState() => _PackListScreenState();
}

class _PackListScreenState extends State<PackListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Packs'),
      ),
    );
  }
}

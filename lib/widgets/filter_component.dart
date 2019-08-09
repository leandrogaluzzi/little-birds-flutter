import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:little_birds/utils/constants.dart';
import 'package:little_birds/widgets/factions_horizontal_scroller.dart';

class FilterComponent extends StatefulWidget {
  @override
  _FilterComponentState createState() => _FilterComponentState();
}

class _FilterComponentState extends State<FilterComponent> {
  Widget _header() {
    return Container(
      height: 60,
      color: kColorYellowLittleBirds,
      child: Center(
        child: Text(
          'Filter',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _titleFactions() {
    return FactionsHorizontalScroller();
  }

  Widget _factions() {
    return Container(
      height: 60,
      color: Colors.white,
    );
  }

  Widget _titleTypes() {
    return Container(
      height: 60,
      color: Colors.grey,
    );
  }

  Widget _types() {
    return Container(
      height: 60,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _header(),
          _titleFactions(),
          _factions(),
          _titleTypes(),
          _types(),
        ],
      ),
    );
  }
}

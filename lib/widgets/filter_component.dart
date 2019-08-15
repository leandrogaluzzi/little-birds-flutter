import 'package:flutter/material.dart';
import 'package:little_birds/model/faction.dart';
import 'package:little_birds/model/card_type.dart';
import 'package:little_birds/model/filter.dart';

class FilterComponent extends StatefulWidget {
  FilterComponent({
    @required this.filter,
  });

  final Filter filter;

  @override
  _FilterComponentState createState() => _FilterComponentState(filter: filter);
}

class _FilterComponentState extends State<FilterComponent> {
  _FilterComponentState({
    @required this.filter,
  });

  Filter filter;

  /*Widget _header() {
    return SliverPersistentHeader(
      delegate: SliverPersistentHeader(delegate: ,);
      ,
    )

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
  }*/

  /*Widget _titleFactions() {
    return Container(
      height: 60,
      color: Colors.grey,
    );
  }

  Widget _factions() {
    return FactionGrid();
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
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          //_header(),
          //_titleFactions(),
          //_factions(),
          //_titleTypes(),
          //_types(),
        ],
      ),
    );
  }
}

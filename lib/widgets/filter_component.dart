import 'package:flutter/material.dart';
import 'package:little_birds/core/filter_manager/filter_manager.dart';
import 'package:little_birds/model/faction.dart';
import 'package:little_birds/model/card_type.dart';
import 'package:little_birds/utils/constants.dart';
import 'package:provider/provider.dart';

class FilterComponent extends StatelessWidget {
  Widget _header() {
    return Container(
      height: 50,
      color: kColorYellowLittleBirds,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.filter_list,
            color: Colors.black,
          ),
          Container(width: 12.0),
          Text(
            'Filter',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _title({String title}) {
    return Container(
      height: 30,
      color: Colors.grey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _factionItem(BuildContext context, Faction faction) {
    final filterManager = Provider.of<FilterManager>(context);
    bool isSelected = false;
    filterManager.filter().factions.contains(faction);
    return Expanded(
      child: RawMaterialButton(
        child: Container(
          height: 70,
          color: isSelected ? Colors.grey[300] : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(faction.icon()),
              Container(height: 5),
              Text(
                faction.toString(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        onPressed: () {
          filterManager.factionSelected(faction);
        },
      ),
    );
  }

  Widget _factions(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _factionItem(context, Faction.values[0]),
            _factionItem(context, Faction.values[1]),
            _factionItem(context, Faction.values[2]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _factionItem(context, Faction.values[3]),
            _factionItem(context, Faction.values[4]),
            _factionItem(context, Faction.values[5]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _factionItem(context, Faction.values[6]),
            _factionItem(context, Faction.values[7]),
            _factionItem(context, Faction.values[8]),
          ],
        ),
      ],
    );
  }

  Widget _typeItem(BuildContext context, CardType type) {
    final filterManager = Provider.of<FilterManager>(context);
    bool isSelected = filterManager.filter().types.contains(type);
    return Expanded(
      child: RawMaterialButton(
        child: Container(
          height: 50,
          color: isSelected ? Colors.grey[300] : Colors.white,
          child: Center(
            child: Text(
              type.toString(),
            ),
          ),
        ),
        onPressed: () {
          filterManager.typeSelected(type);
        },
      ),
    );
  }

  Widget _types(BuildContext context) {
    List<CardType> types = [];
    types.addAll(CardType.values);
    types.remove(CardType.unknown);

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _typeItem(context, types[0]),
            _typeItem(context, types[1]),
            _typeItem(context, types[2]),
            _typeItem(context, types[3]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _typeItem(context, types[4]),
            _typeItem(context, types[5]),
            _typeItem(context, types[6]),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _header(),
                _title(title: 'Factions:'),
                _factions(context),
                _title(title: 'Types:'),
                _types(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

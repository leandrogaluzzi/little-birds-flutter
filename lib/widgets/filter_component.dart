import 'package:flutter/material.dart';
import 'package:little_birds/model/faction.dart';
import 'package:little_birds/model/card_type.dart';
import 'package:little_birds/utils/constants.dart';

class FilterComponent extends StatefulWidget {
  final List<Faction> selectedFactions = [];
  final List<CardType> selectedTypes = [];

  @override
  _FilterComponentState createState() => _FilterComponentState();
}

class _FilterComponentState extends State<FilterComponent> {
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

  Widget _factionItem({Faction faction}) {
    bool isSelected = widget.selectedFactions.contains(faction);
    return Expanded(
      child: RawMaterialButton(
        child: Container(
          height: 60,
          color: isSelected ? Colors.grey[300] : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(faction.icon()),
              Container(height: 5),
              Text(
                faction.toString(),
              ),
            ],
          ),
        ),
        onPressed: () {
          if (isSelected) {
            widget.selectedFactions.remove(faction);
          } else {
            widget.selectedFactions.add(faction);
          }
          setState(() {});
        },
      ),
    );
  }

  Widget _factions() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _factionItem(faction: Faction.values[0]),
            _factionItem(faction: Faction.values[1]),
            _factionItem(faction: Faction.values[2]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _factionItem(faction: Faction.values[3]),
            _factionItem(faction: Faction.values[4]),
            _factionItem(faction: Faction.values[5]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _factionItem(faction: Faction.values[6]),
            _factionItem(faction: Faction.values[7]),
            _factionItem(faction: Faction.values[8]),
          ],
        ),
      ],
    );
  }

  Widget _typeItem({CardType type}) {
    bool isSelected = widget.selectedTypes.contains(type);
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
          if (isSelected) {
            widget.selectedTypes.remove(type);
          } else {
            widget.selectedTypes.add(type);
          }
          setState(() {});
        },
      ),
    );
  }

  Widget _types() {
    List<CardType> types = [];
    types.addAll(CardType.values);
    types.remove(CardType.unknown);

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _typeItem(type: types[0]),
            _typeItem(type: types[1]),
            _typeItem(type: types[2]),
            _typeItem(type: types[3]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _typeItem(type: types[4]),
            _typeItem(type: types[5]),
            _typeItem(type: types[6]),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _header(),
              _title(title: 'Factions:'),
              _factions(),
              _title(title: 'Types:'),
              _types(),
            ],
          ),
        ],
      ),
    );
  }
}

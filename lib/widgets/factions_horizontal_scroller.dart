import 'package:flutter/material.dart';
import 'package:little_birds/model/faction.dart';

class FactionsHorizontalScroller extends StatefulWidget {
  @override
  _FactionsHorizontalScrollerState createState() =>
      _FactionsHorizontalScrollerState();
}

class _FactionsHorizontalScrollerState
    extends State<FactionsHorizontalScroller> {
  final List<Faction> _factions = [
    Faction.baratheon,
    Faction.greyjoy,
    Faction.lannister,
    Faction.martell,
    Faction.neutral,
    Faction.stark,
    Faction.targaryen,
    Faction.theNightsWatch,
    Faction.tyrell,
  ];

  List<Faction> selected = [];

  Widget _item({Faction faction, int index}) {
    bool isSelected = selected.contains(faction);
    return RawMaterialButton(
      child: Container(
        color: isSelected ? Colors.grey : Colors.white,
        width: 60,
        child: Center(
          child: Image.asset(
            'assets/icons/martell.png',
            height: 50.0,
          ),
        ),
      ),
      onPressed: () {
        if (isSelected) {
          selected.remove(faction);
        } else {
          selected.add(faction);
        }
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _factions.length,
        itemBuilder: (context, index) {
          final faction = _factions[index];
          return _item(faction: faction, index: index);
        },
      ),
    );
  }
}

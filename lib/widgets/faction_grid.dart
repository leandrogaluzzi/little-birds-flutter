import 'package:flutter/material.dart';
import 'package:little_birds/model/faction.dart';

class FactionGrid extends StatefulWidget {
  @override
  _FactionGridState createState() => _FactionGridState();
}

class _FactionGridState extends State<FactionGrid> {
  List<Faction> selected = [];

  Widget _item({int index}) {
    Faction faction = Faction.values[index];
    bool isSelected = selected.contains(faction);
    return RawMaterialButton(
      child: Container(
        height: 70,
        color: isSelected ? Colors.grey : Colors.white,
        child: Center(
          child: Container(
            color: Colors.red,
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/icons/${faction.toCode()}.png',
                  scale: 1.0,
                ),
                Text('${faction.toString()}'),
              ],
            ),
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
    return SliverGrid.count(
      crossAxisCount: 3,
      children: List.generate(Faction.values.length, (index) {
        return _item(index: index);
      }),
    );
  }
}

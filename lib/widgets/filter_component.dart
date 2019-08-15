import 'package:flutter/material.dart';
import 'package:little_birds/model/faction.dart';
import 'package:little_birds/model/card_type.dart';
import 'package:little_birds/model/filter.dart';
import 'package:little_birds/utils/constants.dart';

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

  Widget _header() {
    return SliverFixedExtentList(
      itemExtent: 60,
      delegate: SliverChildListDelegate(
        [
          Container(
            height: 60,
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
          ),
        ],
      ),
    );
  }

  Widget _title({String title}) {
    return SliverFixedExtentList(
      itemExtent: 40,
      delegate: SliverChildListDelegate(
        [
          Container(
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
          ),
        ],
      ),
    );
  }

  Widget _factionItem({Faction faction}) {
    print(faction.icon());
    return Container(
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
    );
  }

  Widget _factions() {
    return SliverGrid.count(
      crossAxisCount: 3,
      childAspectRatio: 2,
      children: List.generate(Faction.values.length, (index) {
        var faction = Faction.values[index];
        return _factionItem(faction: faction);
      }),
    );
  }

  Widget _typeItem({CardType type}) {
    return Container(
      child: Center(
        child: Text(
          type.toString(),
        ),
      ),
    );
  }

  Widget _types() {
    List<CardType> types = [];
    types.addAll(CardType.values);
    types.remove(CardType.unknown);

    return SliverGrid.count(
      crossAxisCount: 4,
      childAspectRatio: 2,
      children: List.generate(types.length, (index) {
        var type = types[index];
        return _typeItem(type: type);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          _header(),
          _title(title: 'Factions:'),
          _factions(),
          _title(title: 'Types:'),
          _types(),
        ],
      ),
    );
  }
}

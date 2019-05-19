import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:little_birds/utils/tab_bar_item.dart';
import 'package:little_birds/screens/home_screen.dart';
import 'package:little_birds/screens/pack_list_screen.dart';
import 'package:little_birds/screens/card_list_screen.dart';

class TabBarWidget extends StatelessWidget {
  final List<BottomNavigationBarItem> _items = [
    TabBarItem.buildItem('Home', 'assets/icons/home.png'),
    TabBarItem.buildItem('Packs', 'assets/icons/packs.png'),
    TabBarItem.buildItem('Cards', 'assets/icons/cards.png'),
  ];

  final List<Widget> _tabs = [
    HomeScreen(),
    PackListScreen(),
    CardListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _items,
      ),
      tabBuilder: (BuildContext context, int index) {
        return _tabs[index];
      },
    );
  }
}

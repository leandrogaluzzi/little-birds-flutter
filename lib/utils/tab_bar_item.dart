import 'package:flutter/material.dart';
import 'package:little_birds/utils/constants.dart';

enum TabBarName {
  home,
  packs,
  cards,
  decks,
}

class TabBarItem {
  static Widget _icon({TabBarName name}) {
    switch (name) {
      case TabBarName.home:
        return ImageIcon(
          AssetImage('assets/icons/home.png'),
          size: kTabBarIconSize,
        );
        break;
      case TabBarName.packs:
        return ImageIcon(
          AssetImage('assets/icons/packs.png'),
          size: kTabBarIconSize,
        );
        break;
      case TabBarName.cards:
        return ImageIcon(
          AssetImage('assets/icons/cards.png'),
          size: kTabBarIconSize,
        );
        break;
      case TabBarName.decks:
        return Icon(Icons.person_outline);
        break;
      default:
        return Container();
    }
  }

  static Widget _title({TabBarName name}) {
    switch (name) {
      case TabBarName.home:
        return Text('Home');
        break;
      case TabBarName.packs:
        return Text('Packs');
        break;
      case TabBarName.cards:
        return Text('Cards');
        break;
      case TabBarName.decks:
        return Text('My Decks');
        break;
      default:
        return Text('');
    }
  }

  static BottomNavigationBarItem buildItem({TabBarName name}) {
    return BottomNavigationBarItem(
      icon: _icon(name: name),
      title: _title(name: name),
    );
  }
}

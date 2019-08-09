import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/utils/tab_bar_item.dart';
import 'package:little_birds/screens/home_screen.dart';
import 'package:little_birds/screens/pack_list_screen.dart';
import 'package:little_birds/screens/card_list_screen.dart';
import 'package:little_birds/view_models/card_list_screen_view_model.dart';

class TabBarComponent extends StatelessWidget {
  final List<BottomNavigationBarItem> _items = [
    TabBarItem.buildItem('Home', 'assets/icons/home.png'),
    TabBarItem.buildItem('Packs', 'assets/icons/packs.png'),
    TabBarItem.buildItem('Cards', 'assets/icons/cards.png'),
  ];

  HomeScreen _homeScreen() {
    return HomeScreen();
  }

  PackListScreen _packListScreen() {
    return PackListScreen();
  }

  CardListScreen _cardListScreen(BuildContext context) {
    return CardListScreen(
      viewModel: CardListScreenViewModel(cardsStore: CardsStore.of(context)),
    );
  }

  List<Widget> _tabs(BuildContext context) {
    return [
      _homeScreen(),
      _packListScreen(),
      _cardListScreen(context),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _items,
      ),
      tabBuilder: (BuildContext context, int index) {
        final tabs = _tabs(context);
        return tabs[index];
      },
    );
  }
}

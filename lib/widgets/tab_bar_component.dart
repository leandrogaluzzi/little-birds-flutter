import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:little_birds/screens/user_decks_screen.dart';
import 'package:little_birds/core/services.dart';
import 'package:little_birds/utils/tab_bar_item.dart';
import 'package:little_birds/screens/home_screen.dart';
import 'package:little_birds/screens/pack_list_screen.dart';
import 'package:little_birds/screens/card_list_screen.dart';
import 'package:little_birds/view_models/card_list_screen_view_model.dart';
import 'package:little_birds/view_models/home_screen_view_model.dart';
import 'package:little_birds/view_models/user_decks_view_model.dart';

class TabBarComponent extends StatelessWidget {
  final List<BottomNavigationBarItem> _items = [
    TabBarItem.buildItem(name: TabBarName.home),
    TabBarItem.buildItem(name: TabBarName.packs),
    TabBarItem.buildItem(name: TabBarName.cards),
    TabBarItem.buildItem(name: TabBarName.decks),
  ];

  HomeScreen _homeScreen(BuildContext context) {
    final services = Services.of(context);
    final thrones = services.thronesService;
    final viewModel = HomeScreenViewModel(thrones: thrones);
    return HomeScreen(viewModel: viewModel);
  }

  PackListScreen _packListScreen(BuildContext context) {
    final services = Services.of(context);
    final thrones = services.thronesService;
    return PackListScreen(thrones: thrones);
  }

  CardListScreen _cardListScreen(BuildContext context) {
    final services = Services.of(context);
    final cardsStore = services.cardsStore;
    final viewModel = CardListScreenViewModel(cardsStore: cardsStore);
    return CardListScreen(viewModel: viewModel);
  }

  UserDecksScreen _userDecksScreen(BuildContext context) {
    final services = Services.of(context);
    final thrones = services.thronesService;
    final storage = services.secureStorage;
    final viewModel = UserDecksViewModel(thrones: thrones, storage: storage);
    return UserDecksScreen(viewModel: viewModel);
  }

  List<Widget> _tabs(BuildContext context) {
    return [
      _homeScreen(context),
      _packListScreen(context),
      _cardListScreen(context),
      _userDecksScreen(context),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colors.black,
        inactiveColor: Colors.grey[500],
        items: _items,
      ),
      tabBuilder: (BuildContext context, int index) {
        final tabs = _tabs(context);
        return tabs[index];
      },
    );
  }
}

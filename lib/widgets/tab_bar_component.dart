import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:little_birds/api/thrones_service.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/screens/user_decks_screen.dart';
import 'package:little_birds/utils/tab_bar_item.dart';
import 'package:little_birds/screens/home_screen.dart';
import 'package:little_birds/screens/pack_list_screen.dart';
import 'package:little_birds/screens/card_list_screen.dart';
import 'package:little_birds/view_models/card_list_screen_view_model.dart';
import 'package:little_birds/view_models/home_screen_view_model.dart';
import 'package:little_birds/view_models/user_decks_view_model.dart';

class TabBarComponent extends StatelessWidget {
  TabBarComponent({
    Key key,
    @required this.thrones,
  });

  final ThronesService thrones;

  final List<BottomNavigationBarItem> _items = [
    TabBarItem.buildItem(name: TabBarName.home),
    TabBarItem.buildItem(name: TabBarName.packs),
    TabBarItem.buildItem(name: TabBarName.cards),
    TabBarItem.buildItem(name: TabBarName.decks),
  ];

  HomeScreen _homeScreen() {
    final viewModel = HomeScreenViewModel(thrones: thrones);
    return HomeScreen(viewModel: viewModel);
  }

  PackListScreen _packListScreen() {
    return PackListScreen(
      thrones: thrones,
    );
  }

  CardListScreen _cardListScreen(BuildContext context) {
    final viewModel =
        CardListScreenViewModel(cardsStore: CardsStore.of(context));
    return CardListScreen(viewModel: viewModel);
  }

  UserDecksScreen _userDecksScreen() {
    final viewModel = UserDecksViewModel(thrones: thrones);
    return UserDecksScreen(viewModel: viewModel);
  }

  List<Widget> _tabs(BuildContext context) {
    return [
      _homeScreen(),
      _packListScreen(),
      _cardListScreen(context),
      _userDecksScreen(),
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

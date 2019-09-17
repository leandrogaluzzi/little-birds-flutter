import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:little_birds/core/api/thrones_service_container.dart';
import 'package:little_birds/core/cards_store/cards_store_container.dart';
import 'package:little_birds/core/secure_storage/secure_storage_container.dart';
import 'package:little_birds/utils/tab_bar_item.dart';
import 'package:little_birds/pages/home_page.dart';
import 'package:little_birds/pages/pack_list_page.dart';
import 'package:little_birds/pages/card_list_page.dart';
import 'package:little_birds/pages/user_decks_page.dart';
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

  HomePage _homeScreen(BuildContext context) {
    final thrones = ThronesServiceContainer.of(context).thronesService;
    final viewModel = HomeScreenViewModel(thrones: thrones);
    return HomePage(viewModel: viewModel);
  }

  PackListPage _packListScreen(BuildContext context) {
    return PackListPage();
  }

  CardListPage _cardListScreen(BuildContext context) {
    final cardsStore = CardsStoreContainer.of(context).cardsStore;
    final viewModel = CardListScreenViewModel(cardsStore: cardsStore);
    return CardListPage(viewModel: viewModel);
  }

  UserDecksPage _userDecksScreen(BuildContext context) {
    final thrones = ThronesServiceContainer.of(context).thronesService;
    final storage = SecureStorageContainer.of(context).secureStorage;
    final viewModel = UserDecksViewModel(thrones: thrones, storage: storage);
    return UserDecksPage(viewModel: viewModel);
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

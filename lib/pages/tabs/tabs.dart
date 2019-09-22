import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:little_birds/core/api/thrones_service.dart';
import 'package:little_birds/core/cards_store.dart';
import 'package:little_birds/core/filter_manager.dart';
import 'package:little_birds/core/secure_storage.dart';
import 'package:little_birds/pages/cards/cards_page.dart';
import 'package:little_birds/pages/pack_list/pack_list_page.dart';
import 'package:little_birds/pages/user_decks/user_decks_page.dart';
import 'package:little_birds/pages/user_decks/user_decks_page_view_model.dart';
import 'package:little_birds/utils/tab_bar_item.dart';
import 'package:little_birds/pages/home/home_page.dart';
import 'package:little_birds/pages/home/home_view_model.dart';
import 'package:provider/provider.dart';

class Tabs extends StatelessWidget {
  final List<BottomNavigationBarItem> _items = [
    TabBarItem.buildItem(name: TabBarName.home),
    TabBarItem.buildItem(name: TabBarName.packs),
    TabBarItem.buildItem(name: TabBarName.cards),
    TabBarItem.buildItem(name: TabBarName.decks),
  ];

  Widget _home(BuildContext context) {
    final thrones = Provider.of<DefaultThronesService>(context);
    final viewModel = HomeViewModel(thrones: thrones);
    return HomePage(viewModel: viewModel);
  }

  Widget _packList(BuildContext context) {
    return PackListPage();
  }

  Widget _cardList(BuildContext context) {
    final cardsStore = Provider.of<CardsStore>(context);
    return ChangeNotifierProvider<FilterManager>(
      builder: (_) => FilterManager(cardsStore: cardsStore),
      child: CardsPage(),
    );
  }

  Widget _userDecks(BuildContext context) {
    final thrones = Provider.of<DefaultThronesService>(context);
    final storage = Provider.of<SecureStorage>(context);
    final viewModel =
        UserDecksPageViewModel(thrones: thrones, storage: storage);
    return UserDecksPage(viewModel: viewModel);
  }

  List<Widget> _tabs(BuildContext context) {
    return [
      _home(context),
      _packList(context),
      _cardList(context),
      _userDecks(context),
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

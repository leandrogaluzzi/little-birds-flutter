import 'package:flutter/material.dart';
import 'package:little_birds/core/api/thrones_service_container.dart';
import 'package:little_birds/core/cards_store/cards_store.dart';
import 'package:little_birds/core/cards_store/cards_store_container.dart';
import 'package:little_birds/core/secure_storage/secure_storage.dart';
import 'package:little_birds/core/secure_storage/secure_storage_container.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/screens/request_error_screen.dart';
import 'package:little_birds/screens/request_loading_screen.dart';
import 'package:little_birds/widgets/tab_bar_component.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _widgetLoading() {
    return RequestLoadingScreen(
      title: 'Loading cards ...',
    );
  }

  Widget _widgetError({BuildContext context, Error error}) {
    return RequestErrorScreen(
      title: 'Error loading cards.',
      onPressed: () {
        setState(() {});
      },
    );
  }

  Widget _widgetTabs({List<ThronesCard> cards}) {
    final cardsStore = CardsStore(cards: cards);
    final secureStorage = SecureStorage();

    return CardsStoreContainer(
      cardsStore: cardsStore,
      child: SecureStorageContainer(
        secureStorage: secureStorage,
        child: TabBarComponent(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ThronesCard>>(
      future: ThronesServiceContainer.of(context).thronesService.cards(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ThronesCard>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return _widgetLoading();
          case ConnectionState.done:
            if (snapshot.hasError) return _widgetError(error: snapshot.error);
            return _widgetTabs(cards: snapshot.data);
        }
        return null;
      },
    );
  }
}

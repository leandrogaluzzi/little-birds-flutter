import 'package:flutter/material.dart';
import 'package:little_birds/core/api/thrones_service_container.dart';
import 'package:little_birds/core/cards_store/cards_store.dart';
import 'package:little_birds/core/cards_store/cards_store_container.dart';
import 'package:little_birds/core/secure_storage/secure_storage.dart';
import 'package:little_birds/core/secure_storage/secure_storage_container.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/widgets/tab_bar_component.dart';
import 'request_error_page.dart';
import 'request_loading_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget _widgetLoading() {
    return RequestLoadingPage(
      title: 'Loading cards ...',
    );
  }

  Widget _widgetError({BuildContext context, Error error}) {
    return RequestErrorPage(
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

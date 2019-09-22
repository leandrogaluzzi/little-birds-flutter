import 'package:flutter/material.dart';
import 'package:little_birds/core/api/thrones_service.dart';
import 'package:little_birds/core/cards_store.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/pages/tabs/tabs.dart';
import 'package:little_birds/widgets/request_error_view.dart';
import 'package:little_birds/widgets/request_loading_view.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget _widgetLoading() {
    return RequestLoadingView(
      title: 'Loading cards ...',
    );
  }

  Widget _widgetError({BuildContext context, Error error}) {
    return RequestErrorView(
      title: 'Error loading cards.',
      onPressed: () {
        setState(() {});
      },
    );
  }

  Widget _widgetTabs({List<ThronesCard> cards}) {
    return ChangeNotifierProvider<CardsStore>(
      builder: (_) => CardsStore(cards: cards),
      child: Tabs(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ThronesCard>>(
      future: Provider.of<DefaultThronesService>(context).cards(),
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

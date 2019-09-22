import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_birds/core/analytics/analytics.dart';
import 'package:little_birds/core/analytics/analytics_screen.dart';
import 'package:little_birds/core/api/thrones_service.dart';
import 'package:little_birds/core/cards_store.dart';
import 'package:little_birds/model/thrones_pack.dart';
import 'package:little_birds/pages/pack_list/pack_cell/pack_cell.dart';
import 'package:little_birds/pages/pack_list/pack_cell/pack_cell_view_model.dart';
import 'package:little_birds/pages/pack/pack_page.dart';
import 'package:little_birds/widgets/request_error_view.dart';
import 'package:little_birds/widgets/separator.dart';
import 'package:provider/provider.dart';

class PackListPage extends StatefulWidget with AnalyticsScreen {
  @override
  String get screenName => 'PackList';

  @override
  _PackListPageState createState() => _PackListPageState();
}

class _PackListPageState extends State<PackListPage> {
  void _onPackSelected({BuildContext context, ThronesPack pack}) async {
    Analytics.trackPack(pack);
    final cardsStore = Provider.of<CardsStore>(context);
    final cards = cardsStore.cardsWithPackCode(pack.code);
    //await
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return PackPage(
            title: pack.name,
            cards: cards,
          );
        },
      ),
    );
    //Ads.showInterestial(context);
  }

  Widget _widgetLoading() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    );
  }

  Widget _widgetError({Error error}) {
    return RequestErrorView(
      title: 'Error loading packs',
      onPressed: () {
        setState(() {});
      },
    );
  }

  Widget _widgetList({@required List<ThronesPack> packs}) {
    return ListView.separated(
      itemCount: packs.length,
      itemBuilder: (BuildContext context, int index) {
        final pack = packs[index];
        final viewModel = PackCellViewModel(pack: pack);
        return PackCell(
          viewModel: viewModel,
          onTap: () {
            _onPackSelected(context: context, pack: pack);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Separator();
      },
    );
  }

  List<ThronesPack> _reorderPacks(List<ThronesPack> packs) {
    List<ThronesPack> reorderedPacks = packs;
    reorderedPacks.sort((a, b) {
      if (a.cyclePosition != b.cyclePosition) {
        return b.cyclePosition.compareTo(a.cyclePosition);
      } else {
        return b.position.compareTo(a.position);
      }
    });
    return reorderedPacks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Packs'),
      ),
      body: FutureBuilder<List<ThronesPack>>(
        future: Provider.of<DefaultThronesService>(context).packs(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ThronesPack>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return _widgetLoading();
            case ConnectionState.done:
              if (snapshot.hasError) return _widgetError(error: snapshot.error);
              return _widgetList(packs: _reorderPacks(snapshot.data));
          }
          return null;
        },
      ),
    );
  }
}

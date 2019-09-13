import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_birds/ads/ads.dart';
import 'package:little_birds/analytics/analytics.dart';
import 'package:little_birds/analytics/analytics_screen.dart';
import 'package:little_birds/model/thrones_pack.dart';
import 'package:little_birds/networking/thrones_service.dart';
import 'package:little_birds/screens/request_error_screen.dart';
import 'package:little_birds/widgets/pack_list_item.dart';
import 'package:little_birds/screens/pack_screen.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/widgets/separator.dart';

class PackListScreen extends StatefulWidget with AnalyticsScreen {
  @override
  String get screenName => 'PackList';

  @override
  _PackListScreenState createState() => _PackListScreenState();
}

class _PackListScreenState extends State<PackListScreen> {
  Future _packs;
  final ThronesService thronesService = ThronesService();

  @override
  void initState() {
    _packs = thronesService.getPacks();
    super.initState();
  }

  void _onPackSelected({BuildContext context, ThronesPack pack}) async {
    Analytics.trackPack(pack);
    final cards = CardsStore.of(context).getCardsWithPackCode(pack.code);
    await Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return PackScreen(
            title: pack.name,
            cards: cards,
          );
        },
      ),
    );
    Ads.showInterestial(context);
  }

  Widget _widgetLoading() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    );
  }

  Widget _widgetError({Error error}) {
    return RequestErrorScreen(
      title: 'Error loading packs',
      onPressed: () {
        setState(() {
          _packs = thronesService.getPacks();
        });
      },
    );
  }

  Widget _widgetList({@required List<ThronesPack> packs}) {
    return ListView.separated(
      itemCount: packs.length,
      itemBuilder: (BuildContext context, int index) {
        final pack = packs[index];
        return PackListItem(
          pack: pack,
          index: index,
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
        future: _packs,
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

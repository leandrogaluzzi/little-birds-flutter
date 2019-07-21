import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_birds/model/thrones_pack.dart';
import 'package:little_birds/networking/thrones_service.dart';
import 'package:little_birds/widgets/pack_list_item.dart';
import 'package:little_birds/screens/pack_screen.dart';
import 'package:little_birds/cards_store.dart';

class PackListScreen extends StatefulWidget {
  @override
  _PackListScreenState createState() => _PackListScreenState();
}

class _PackListScreenState extends State<PackListScreen> {
  Future _packs;

  @override
  void initState() {
    ThronesService thronesService = ThronesService();
    _packs = thronesService.getPacks();
    super.initState();
  }

  void _onPackSelected({BuildContext context, ThronesPack pack}) {
    final cards = CardsStore.of(context).getCardsWithPackCode(pack.code);
    Navigator.push(
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
  }

  Widget _widgetLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _widgetError({Error error}) {
    return Container(color: Colors.red);
  }

  Widget _widgetList({@required List<ThronesPack> packs}) {
    return ListView.builder(
      itemCount: packs.length,
      itemBuilder: (BuildContext context, int index) {
        final pack = packs[index];
        return PackListItem(
            pack: pack,
            index: index,
            onTap: () {
              _onPackSelected(context: context, pack: pack);
            });
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
        builder: (BuildContext context, AsyncSnapshot<List<ThronesPack>> snapshot) {
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

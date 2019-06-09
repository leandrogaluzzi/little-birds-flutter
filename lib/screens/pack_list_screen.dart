import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_birds/model/pack.dart';
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

  void _onPackSelected({BuildContext context, Pack pack}) {
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

  Widget _widgetList({@required List<Pack> packs}) {
    return ListView.separated(
      itemCount: packs.length,
      itemBuilder: (BuildContext context, int index) {
        final pack = packs[index];
        return PackListItem(
            pack: pack,
            onTap: () {
              _onPackSelected(context: context, pack: pack);
            });
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Container(
            height: 1,
            color: Colors.blueGrey[100],
          ),
        );
      },
    );
  }

  List<Pack> _reorderPacks(List<Pack> packs) {
    List<Pack> reorderedPacks = packs;
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
      body: FutureBuilder<List<Pack>>(
        future: _packs,
        builder: (BuildContext context, AsyncSnapshot<List<Pack>> snapshot) {
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

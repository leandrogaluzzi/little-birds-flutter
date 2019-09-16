import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_birds/core/api/thrones_service.dart';
import 'package:little_birds/core/services.dart';
import 'package:little_birds/model/auth.dart';
import 'package:little_birds/model/thrones_deck.dart';
import 'package:little_birds/screens/deck_screen.dart';
import 'package:little_birds/screens/request_error_screen.dart';
import 'package:little_birds/view_models/deck_screen_view_model.dart';
import 'package:little_birds/view_models/user_decks_list_item_view_model.dart';
import 'package:little_birds/widgets/separator.dart';
import 'package:little_birds/widgets/user_decks_list_item.dart';

class UserDecksList extends StatefulWidget {
  UserDecksList({
    Key key,
    @required this.auth,
    @required this.thrones,
  })  : assert(thrones != null),
        assert(auth != null),
        super(key: key);

  final ThronesService thrones;
  final Auth auth;

  @override
  _UserDecksListState createState() => _UserDecksListState();
}

class _UserDecksListState extends State<UserDecksList> {
  Future _userDecks;

  @override
  void initState() {
    super.initState();
    _userDecks = widget.thrones.userDecks(accessToken: widget.auth.accessToken);
  }

  void _onDeckSelected({BuildContext context, ThronesDeck deck}) async {
    final services = Services.of(context);
    final cardsStore = services.cardsStore;
    final viewModel = DeckScreenViewModel(deck: deck, cardsStore: cardsStore);
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return DeckScreen(
            viewModel: viewModel,
          );
        },
      ),
    );
  }

  Future<void> _refresh() async {
    //await viewModel.
    //setState(() {});
  }

  Widget _listItem({BuildContext context, ThronesDeck deck}) {
    final services = Services.of(context);
    final cardsStore = services.cardsStore;
    final cards = cardsStore.getCardsFromSlots(deck.slots);
    final viewModel = UserDecksListItemViewModel(deck: deck, cards: cards);
    return UserDecksListItem(
      viewModel: viewModel,
      onTap: () {
        _onDeckSelected(context: context, deck: deck);
      },
    );
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    );
  }

  Widget _error({Error error}) {
    return RequestErrorScreen(
      title: 'Error loading decks',
      onPressed: () {
        setState(() {
          _userDecks =
              widget.thrones.userDecks(accessToken: widget.auth.accessToken);
        });
      },
    );
  }

  Widget _list({List<ThronesDeck> decks}) {
    final count = decks.length;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.separated(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          final deck = decks[index];
          return _listItem(context: context, deck: deck);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Separator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ThronesDeck>>(
      future: _userDecks,
      builder:
          (BuildContext context, AsyncSnapshot<List<ThronesDeck>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return _loading();
          case ConnectionState.done:
            if (snapshot.hasError) return _error(error: snapshot.error);
            return _list(decks: snapshot.data);
        }
        return null;
      },
    );
  }
}

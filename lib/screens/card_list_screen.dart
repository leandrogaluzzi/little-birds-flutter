import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/screens/card_screen.dart';
import 'package:little_birds/utils/constants.dart';
import 'package:little_birds/view_models/card_screen_view_model.dart';
import 'package:little_birds/widgets/card_list.dart';
import 'package:little_birds/widgets/search_field.dart';

class CardListScreen extends StatefulWidget {
  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  String query;
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        isKeyboardVisible = visible;
        setState(() {});
      },
    );
  }

  List<ThronesCard> _cards() {
    if (query == null || query == '') {
      return CardsStore.of(context).getCardsAlphabetically();
    } else {
      return CardsStore.of(context).getCardsWithQuery(query);
    }
  }

  void _onCardSelected({BuildContext context, card: ThronesCard}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          final viewModel = CardScreenViewModel(card: card);
          return CardScreen(viewModel: viewModel);
        },
      ),
    );
  }

  void _onTextSubmitted({BuildContext context}) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void _onTextChanged({String text}) {
    query = text;
    setState(() {});
  }

  Widget _searchField({BuildContext context}) {
    return SearchField(
      onChanged: (String text) {
        _onTextChanged(text: text);
      },
      onSubmitted: () {
        _onTextSubmitted(context: context);
      },
    );
  }

  Widget _filterButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 80.0),
      child: FloatingActionButton(
        child: Icon(
          Icons.filter_list,
          color: Colors.black,
        ),
        onPressed: () {},
        backgroundColor: kColorYellowLittleBirds,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = _cards();
    return Scaffold(
      appBar: AppBar(
        title: _searchField(context: context),
      ),
      body: CardList(
        cards: cards,
        onTap: (ThronesCard card) {
          _onCardSelected(context: context, card: card);
        },
      ),
      floatingActionButton: isKeyboardVisible ? null : _filterButton(),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:little_birds/analytics/analytics.dart';
import 'package:little_birds/model/filter.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/screens/card_screen.dart';
import 'package:little_birds/utils/constants.dart';
import 'package:little_birds/view_models/card_list_screen_view_model.dart';
import 'package:little_birds/view_models/card_screen_view_model.dart';
import 'package:little_birds/widgets/card_list.dart';
import 'package:little_birds/widgets/filter_component.dart';
import 'package:little_birds/widgets/search_field.dart';

class CardListScreen extends StatefulWidget {
  CardListScreen({
    @required this.viewModel,
  }) : assert(viewModel != null);

  final CardListScreenViewModel viewModel;

  @override
  _CardListScreenState createState() =>
      _CardListScreenState(viewModel: viewModel);
}

class _CardListScreenState extends State<CardListScreen> {
  _CardListScreenState({
    @required this.viewModel,
  }) : assert(viewModel != null);

  final CardListScreenViewModel viewModel;
  String _query;
  bool _isKeyboardVisible = false;
  Filter _filter = Filter(factions: [], types: []);
  FilterComponent _filterComponent = FilterComponent();

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        _isKeyboardVisible = visible;
        setState(() {});
      },
    );
  }

  void _onCardSelected({BuildContext context, card: ThronesCard}) {
    Analytics.trackCard(card);
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

  void _showFilterWidget(BuildContext context) {
    Future<Filter> future = showModalBottomSheet(
      context: context,
      builder: (context) {
        return _filterComponent;
      },
      isScrollControlled: true,
    );

    future.then((value) {
      _filter.factions = _filterComponent.selectedFactions;
      _filter.types = _filterComponent.selectedTypes;
      setState(() {});
    });
  }

  void _onTextSubmitted({BuildContext context}) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void _onTextChanged({String text}) {
    _query = text;
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

  Widget _filterButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 80.0),
      child: FloatingActionButton(
        child: Icon(
          Icons.filter_list,
          color: Colors.black,
        ),
        onPressed: () {
          _showFilterWidget(context);
        },
        backgroundColor: kColorYellowLittleBirds,
      ),
    );
  }

  Widget _cardList(BuildContext context, List<ThronesCard> cards) {
    return CardList(
      cards: cards,
      onTap: (ThronesCard card) {
        _onCardSelected(context: context, card: card);
      },
    );
  }

  Widget _emptyList() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'No cards found',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          Container(height: 12.0),
          Text(
            'Please, try again',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    final cards = viewModel.cards(query: _query, filter: _filter);
    return cards.length > 0 ? _cardList(context, cards) : _emptyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchField(context: context),
      ),
      body: _body(context),
      floatingActionButton: _isKeyboardVisible ? null : _filterButton(context),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:little_birds/core/analytics/analytics.dart';
import 'package:little_birds/core/analytics/analytics_screen.dart';
import 'package:little_birds/core/filter_manager.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/pages/card/card_page.dart';
import 'package:little_birds/pages/card/card_page_view_model.dart';
import 'package:little_birds/widgets/card_list.dart';
import 'package:little_birds/widgets/filter_component.dart';
import 'package:little_birds/widgets/search_field.dart';
import 'package:provider/provider.dart';

class CardsPage extends StatefulWidget with AnalyticsScreen {
  @override
  String get screenName => 'CardList';

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  bool _isKeyboardVisible = false;

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

  void _onCardSelected({BuildContext context, card: ThronesCard}) async {
    Analytics.trackCard(card);
    //await
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          final viewModel = CardPageViewModel(card: card);
          return CardPage(viewModel: viewModel);
        },
      ),
    );
    //Ads.showInterestial(context);
  }

  void _showFilterWidget() {
    final filterManager = Provider.of<FilterManager>(context);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: filterManager,
          child: FilterComponent(),
        );
      },
      isScrollControlled: true,
    );
  }

  void _onTextSubmitted({BuildContext context}) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void _onTextChanged({String text}) {
    final filterManager = Provider.of<FilterManager>(context);
    filterManager.search(query: text);
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
    return IconButton(
      icon: Icon(Icons.filter_list),
      onPressed: () {
        _showFilterWidget();
      },
    );
  }

  Widget _cancelButton() {
    return RawMaterialButton(
      child: Text(
        'Cancel',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      onPressed: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
    );
  }

  Widget _cardList({List<ThronesCard> cards}) {
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

  @override
  Widget build(BuildContext context) {
    final filterManager = Provider.of<FilterManager>(context);
    final cards = filterManager.cards();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5.0,
        title: _searchField(context: context),
        actions: <Widget>[
          _isKeyboardVisible ? _cancelButton() : _filterButton(),
        ],
      ),
      body: cards.length > 0 ? _cardList(cards: cards) : _emptyList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:little_birds/core/analytics/analytics.dart';
import 'package:little_birds/core/analytics/analytics_screen.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/view_models/card_page_view_model.dart';
import 'package:little_birds/widgets/card_list.dart';
import 'card_page.dart';

class PackPage extends StatelessWidget with AnalyticsScreen {
  PackPage({
    Key key,
    @required this.title,
    @required this.cards,
  })  : assert(title != null),
        assert(cards != null),
        super(key: key);

  final List<ThronesCard> cards;
  final String title;

  @override
  String get screenName => 'Pack';

  void _onCardSelected({BuildContext context, card: ThronesCard}) {
    Analytics.trackCard(card);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        final viewModel = CardPageViewModel(card: card);
        return CardPage(viewModel: viewModel);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    cards.sort((a, b) {
      return b.code.compareTo(a.code);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CardList(
        cards: cards,
        onTap: (ThronesCard card) {
          _onCardSelected(context: context, card: card);
        },
      ),
    );
  }
}

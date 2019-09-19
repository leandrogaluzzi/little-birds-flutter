import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_birds/core/analytics/analytics.dart';
import 'package:little_birds/core/analytics/analytics_event.dart';
import 'package:little_birds/core/analytics/analytics_screen.dart';
import 'package:little_birds/pages/card/card_page_view_model.dart';
import 'package:little_birds/pages/card_image/card_image_page.dart';
import 'package:little_birds/utils/constants.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:little_birds/model/card_type.dart';

class CardPage extends StatelessWidget with AnalyticsScreen {
  CardPage({
    Key key,
    @required this.viewModel,
  })  : assert(viewModel != null),
        super(key: key);

  final CardPageViewModel viewModel;

  @override
  String get screenName => 'Card';

  void _onImageSelected({BuildContext context}) {
    Analytics.track(event: AnalyticsEvent.card_image);
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          final imageScreen = CardImagePage(url: viewModel.card.imageUrl);
          return imageScreen;
        },
      ),
    );
  }

  Widget _widgetImage({BuildContext context}) {
    return Container(
      height: viewModel.card.cardType() == CardType.plot ? null : 425.0,
      child: RawMaterialButton(
        onPressed: () {
          _onImageSelected(context: context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Image.network(
            viewModel.card.imageUrl,
          ),
        ),
      ),
    );
  }

  Widget _widgetHouse() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
              child: Image.asset(
                viewModel.card.iconName(),
              ),
            ),
          ),
          Text(
            viewModel.card.factionName,
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetInfo() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          viewModel.details(),
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
      ),
    );
  }

  Widget _widgetTraits() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          viewModel.card.traits,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17.0,
            color: kColorGrayText,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _widgetText() {
    return Container(
      child: Html(
        data: '<center>${viewModel.card.text}</center>',
        padding: EdgeInsets.symmetric(vertical: 0.0),
        defaultTextStyle: TextStyle(
          fontSize: 17.0,
        ),
      ),
    );
  }

  Widget _widgetIcons() {
    return Center(
      child: Container(
        height: 70.0,
        width: 250.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Opacity(
                opacity: viewModel.card.isMilitary ? 1.0 : 0.1,
                child: Image.asset('assets/icons/military.png'),
              ),
              Opacity(
                opacity: viewModel.card.isIntrigue ? 1.0 : 0.1,
                child: Image.asset('assets/icons/intrigue.png'),
              ),
              Opacity(
                opacity: viewModel.card.isPower ? 1.0 : 0.1,
                child: Image.asset('assets/icons/power.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _widgetFlavor() {
    return Container(
      child: Html(
        data: '<center>${viewModel.card.flavor}</center>',
        padding: EdgeInsets.all(0.0),
        defaultTextStyle: TextStyle(
          fontSize: 15.0,
          fontStyle: FontStyle.italic,
          color: kColorGrayText,
        ),
      ),
    );
  }

  Widget _widgetPack() {
    return Container(
      height: 45.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          viewModel.pack(),
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(viewModel.card.name),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: <Widget>[
              if (viewModel.card.imageUrl != null)
                _widgetImage(context: context),
              _widgetHouse(),
              _widgetInfo(),
              if (viewModel.card.traits.isNotEmpty) _widgetTraits(),
              _widgetText(),
              if (viewModel.card.cardType() == CardType.character)
                _widgetIcons(),
              if (viewModel.card.flavor != null) _widgetFlavor(),
              _widgetPack(),
            ],
          ),
        ));
  }
}

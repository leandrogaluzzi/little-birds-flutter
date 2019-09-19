import 'package:flutter/material.dart';
import 'package:little_birds/utils/constants.dart';
import 'package:little_birds/utils/keys.dart';
import 'package:url_launcher/url_launcher.dart';

class DeckFooter extends StatelessWidget {
  DeckFooter({
    Key key,
    @required this.url,
  })  : assert(url != null),
        super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      floating: false,
      delegate: _DeckFooterDelegate(url: url),
    );
  }
}

class _DeckFooterDelegate extends SliverPersistentHeaderDelegate {
  _DeckFooterDelegate({
    @required this.url,
  }) : assert(url != null);

  final String url;

  _openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: Center(
        child: RaisedButton(
          key: Keys.moreInfoButton,
          color: kColorYellowLittleBirds,
          onPressed: () => _openURL(url),
          child: Text('More on ThronesDB'),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

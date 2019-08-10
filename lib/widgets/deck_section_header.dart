import 'package:flutter/material.dart';

class DeckSectionHeader extends StatelessWidget {
  DeckSectionHeader({
    @required this.text,
  }) : assert(text != null);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container();
    /*SliverPersistentHeader(
      pinned: false,
      floating: false,
      delegate: _DeckSectionHeaderDelegate(text: text),
    );*/
  }
}

/*class _DeckSectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  _DeckSectionHeaderDelegate({
    @required this.text,
  }) : assert(text != null);

  final String text;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Expanded(
      child: Container(
        color: Colors.black,
        child: Text(
          '', //text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}*/

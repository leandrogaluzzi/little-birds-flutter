import 'package:flutter/material.dart';

class DeckSectionHeader extends StatelessWidget {
  DeckSectionHeader({
    @required this.text,
  }) : assert(text != null);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      floating: false,
      delegate: _DeckSectionHeaderDelegate(text: text),
    );
  }
}

class _DeckSectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  _DeckSectionHeaderDelegate({
    @required this.text,
  }) : assert(text != null);

  final String text;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 35,
      color: Colors.grey[500],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 35;

  @override
  double get minExtent => 35;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

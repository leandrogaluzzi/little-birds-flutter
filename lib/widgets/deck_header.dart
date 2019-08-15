import 'package:flutter/material.dart';
import 'package:little_birds/utils/constants.dart';
import 'package:little_birds/view_models/deck_header_view_model.dart';

class DeckHeader extends StatelessWidget {
  DeckHeader({
    @required this.viewModel,
  }) : assert(viewModel != null);

  final DeckHeaderViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      floating: false,
      delegate: _DeckHeaderDelegate(viewModel: viewModel),
    );
  }
}

class _DeckHeaderDelegate extends SliverPersistentHeaderDelegate {
  _DeckHeaderDelegate({
    @required this.viewModel,
  }) : assert(viewModel != null);

  DeckHeaderViewModel viewModel;

  Widget _icon() {
    return Container(
      height: 60,
      child: Center(
        child: Image.asset(viewModel.icon()),
      ),
    );
  }

  Widget _name() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(
          viewModel.name(),
          maxLines: 3,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _info() {
    return Container(
      child: Center(
        child: Text(
          viewModel.info(),
          style: TextStyle(
            fontSize: 16.0,
            color: kColorGrayText,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: Column(
        children: <Widget>[
          _icon(),
          _name(),
          Container(height: 10),
          _info(),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 140;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

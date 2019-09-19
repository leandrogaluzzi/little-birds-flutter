import 'package:flutter/material.dart';
import 'package:little_birds/pages/deck/deck_header/deck_header_view_model.dart';
import 'package:little_birds/utils/constants.dart';

class DeckHeader extends StatelessWidget {
  DeckHeader({
    Key key,
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

  Widget _faction() {
    return Container(
      child: Center(
        child: Text(
          viewModel.faction(),
          style: TextStyle(
            fontSize: 16.0,
            color: kColorGrayText,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _icon(),
          SizedBox(height: 5),
          _name(),
          SizedBox(height: 5),
          _faction(),
          SizedBox(height: 5),
          _info(),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 160;

  @override
  double get minExtent => 160;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

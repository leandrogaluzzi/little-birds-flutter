import 'package:flutter/material.dart';
import 'package:little_birds/utils/constants.dart';
import 'package:little_birds/view_models/user_decks_list_item_view_model.dart';

const double kSmallPadding = 7.0;

final TextStyle _kTextStyle = TextStyle(
  fontSize: 14.0,
  color: kColorGrayText,
);

class UserDecksListItem extends StatelessWidget {
  UserDecksListItem({
    Key key,
    @required this.viewModel,
    @required this.onTap,
  })  : assert(viewModel != null),
        super(key: key);

  final UserDecksListItemViewModel viewModel;
  final VoidCallback onTap;

  Widget _icon() {
    return Container(
      width: 70,
      child: Center(
        child: Image.asset(
          viewModel.iconName(),
        ),
      ),
    );
  }

  Widget _name() {
    return Text(
      viewModel.name(),
      maxLines: 3,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _faction() {
    return Text(
      viewModel.factionName(),
      style: _kTextStyle,
    );
  }

  Widget _agenda() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: FittedBox(
          child: Text(
            viewModel.agendas(),
            style: _kTextStyle,
          ),
        ),
      ),
    );
  }

  Widget _column() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _name(),
          _faction(),
          _agenda(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _icon(),
          _column(),
        ],
      ),
    );
  }
}

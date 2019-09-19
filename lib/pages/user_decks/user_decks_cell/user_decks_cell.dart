import 'package:flutter/material.dart';
import 'package:little_birds/pages/user_decks/user_decks_cell/user_decks_cell_view_model.dart';
import 'package:little_birds/utils/constants.dart';

const double kSmallPadding = 7.0;

final TextStyle _kTextStyle = TextStyle(
  fontSize: 14.0,
  color: kColorGrayText,
);

class UserDecksCell extends StatelessWidget {
  UserDecksCell({
    Key key,
    @required this.viewModel,
    @required this.onTap,
  })  : assert(viewModel != null),
        super(key: key);

  final UserDecksCellViewModel viewModel;
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
    return RawMaterialButton(
      onPressed: onTap,
      child: Container(
        height: 85,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _icon(),
            _column(),
          ],
        ),
      ),
    );
  }
}

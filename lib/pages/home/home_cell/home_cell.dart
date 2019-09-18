import 'package:flutter/material.dart';
import 'package:little_birds/pages/home/home_cell/home_list_item_view_model.dart';
import 'package:little_birds/utils/constants.dart';

const double kSmallPadding = 7.0;
const double kPadding = 12.0;

final TextStyle _kTextStyle = TextStyle(
  fontSize: 14.0,
  color: kColorGrayText,
);

class HomeCell extends StatelessWidget {
  HomeCell({
    Key key,
    @required this.viewModel,
    @required this.onTap,
  })  : assert(viewModel != null),
        super(key: key);

  final HomeCellViewModel viewModel;
  final VoidCallback onTap;

  Widget _icon() {
    return Container(
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
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _date() {
    return Positioned(
      right: kSmallPadding,
      bottom: kPadding,
      child: Text(
        viewModel.time(),
        style: TextStyle(
          fontSize: 12.0,
          color: kColorGrayText,
        ),
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
        child: Text(
          viewModel.agendas(),
          maxLines: 3,
          style: _kTextStyle,
        ),
      ),
    );
  }

  Widget _image() {
    final imageUrl = viewModel.imageUrl();
    return Padding(
      padding: EdgeInsets.only(
        left: kSmallPadding,
        top: kPadding,
        bottom: kPadding,
      ),
      child: Container(
        height: 200,
        child: Image.network(
          imageUrl,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  Widget _column() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(kSmallPadding),
        child: Column(
          children: <Widget>[
            _icon(),
            SizedBox(height: kSmallPadding),
            _name(),
            SizedBox(height: kSmallPadding),
            _faction(),
            SizedBox(height: kSmallPadding),
            _agenda(),
          ],
        ),
      ),
    );
  }

  Widget _row() {
    return Row(
      children: <Widget>[
        _image(),
        _column(),
      ],
    );
  }

  Widget _stack() {
    return Stack(
      children: <Widget>[
        _row(),
        _date(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onTap,
      child: Container(
        color: Colors.white,
        child: _stack(),
      ),
    );
  }
}

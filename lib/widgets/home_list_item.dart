import 'package:flutter/material.dart';
import 'package:little_birds/view_models/home_list_item_view_model.dart';

const double kSmallPadding = 7.0;
const double kPadding = 12.0;

final TextStyle _kTextStyle = TextStyle(
  fontSize: 16.0,
  color: Colors.black,
);

class HomeListItem extends StatelessWidget {
  HomeListItem({
    Key key,
    @required this.viewModel,
    @required this.index,
    @required this.onTap,
  })  : assert(viewModel != null),
        super(key: key);

  final HomeListItemViewModel viewModel;
  final VoidCallback onTap;
  final int index;

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
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _date() {
    return Text(
      viewModel.time(),
      style: _kTextStyle,
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
    return Container(
      height: 200,
      child: Image.network(
        imageUrl,
        fit: BoxFit.scaleDown,
      ),
    );
  }

  Widget _column() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(kSmallPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _icon(),
            SizedBox(height: kSmallPadding),
            _name(),
            SizedBox(height: kSmallPadding),
            _faction(),
            SizedBox(height: kSmallPadding),
            _agenda(),
            SizedBox(height: kSmallPadding),
            _date(),
          ],
        ),
      ),
    );
  }

  Widget _row() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _image(),
          _column(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onTap,
      child: Container(
        color: index % 2 == 0 ? Colors.white : Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            children: <Widget>[
              _row(),
            ],
          ),
        ),
      ),
    );
  }
}

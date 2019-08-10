import 'package:flutter/material.dart';
import 'package:little_birds/view_models/home_list_item_view_model.dart';

const double kSmallPadding = 7.0;
const double kPadding = 12.0;

final TextStyle _kTextStyleBlackSmall = TextStyle(
  fontSize: 18.0,
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

  Widget _getRowName() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(child: Center(child: Image.asset(viewModel.iconName()))),
          Container(width: kPadding),
          Flexible(
            child: Text(
              viewModel.name(),
              maxLines: 3,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRowFaction() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              viewModel.factionName(),
              style: _kTextStyleBlackSmall,
            ),
            Text(
              viewModel.time(),
              style: _kTextStyleBlackSmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getRowAgenda() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Text(
          viewModel.agendas(),
          style: _kTextStyleBlackSmall,
        ),
      ),
    );
  }

  Widget _getRowInfo() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Text(
          viewModel.details(),
          textAlign: TextAlign.center,
          style: _kTextStyleBlackSmall,
        ),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _getRowName(),
              Container(height: kPadding),
              _getRowFaction(),
              Container(height: kSmallPadding),
              _getRowAgenda(),
              Container(height: kSmallPadding),
              _getRowInfo(),
            ],
          ),
        ),
      ),
    );
  }
}

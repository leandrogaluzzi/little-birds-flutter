import 'package:flutter/material.dart';
import 'package:little_birds/utils/constants.dart';
import 'package:little_birds/view_models/home_list_item_view_model.dart';

const double kPadding = 7.0;

class HomeListItem extends StatelessWidget {
  HomeListItem({
    Key key,
    @required this.viewModel,
    @required this.onTap,
  })  : assert(viewModel != null),
        super(key: key);

  final HomeListItemViewModel viewModel;
  final VoidCallback onTap;

  Widget _getRowName() {
    return Container(
      color: Colors.yellow,
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            child: Center(
              child: Image.asset(
                viewModel.getIconName(),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                right: kPadding * 2,
                top : kPadding * 3,
                bottom: kPadding * 3,
              ),
              child: Text(
                viewModel.getName(),
                maxLines: 3,
                style: TextStyle(
                  fontSize: 20.0,
                ),
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
        padding: const EdgeInsets.all(kPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              viewModel.getFactionName(),
              style: kTextStyleBlackSmall,
            ),
            Text(
              viewModel.getTime(),
              style: kTextStyleBlackSmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getRowAgenda() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding),
        child: Text(
          viewModel.getAgendas(),
          style: kTextStyleBlackSmall,
        ),
      ),
    );
  }

  Widget _getRowInfo() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Text(
          viewModel.getInfo(),
          textAlign: TextAlign.center,
          style: kTextStyleBlackSmall,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 6.0,
        ),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _getRowName(),
              _getRowFaction(),
              _getRowAgenda(),
              _getRowInfo(),
            ],
          ),
        ),
      ),
    );
  }
}

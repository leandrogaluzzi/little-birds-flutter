import 'package:flutter/material.dart';
import 'package:little_birds/view_models/home_list_item_view_model.dart';

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
      child: Text(
        viewModel.getName(),
      ),
    );
  }

  Widget _getRowFaction() {
    return Container(
      color: Colors.yellow,
      child: Text(
        viewModel.getFactionName(),
      ),
    );
  }

  Widget _getRowAgenda() {
    return Container(
      color: Colors.yellow,
      child: Text(viewModel.getAgendas()),
    );
  }

  Widget _getRowInfo() {
    return Container(
      color: Colors.yellow,
      child: Text(viewModel.getInfo()),
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
          color: Colors.green,
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

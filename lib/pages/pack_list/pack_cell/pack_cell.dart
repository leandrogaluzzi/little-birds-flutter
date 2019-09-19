import 'package:flutter/material.dart';
import 'package:little_birds/pages/pack_list/pack_cell/pack_cell_view_model.dart';
import 'package:little_birds/utils/constants.dart';

class PackCell extends StatelessWidget {
  PackCell({
    Key key,
    @required this.viewModel,
    @required this.onTap,
  })  : assert(viewModel != null),
        super(key: key);

  final PackCellViewModel viewModel;
  final VoidCallback onTap;

  final TextStyle _textStyleName = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  Widget _widgetName() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        child: Text(
          viewModel.name(),
          style: _textStyleName,
        ),
      ),
    );
  }

  Widget _widgetText(String text) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
            color: kColorGrayText,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 60.0,
      child: RawMaterialButton(
        onPressed: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _widgetName(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _widgetText(viewModel.cycle()),
                _widgetText(viewModel.number()),
              ],
            )
          ],
        ),
      ),
    );
  }
}

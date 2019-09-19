import 'package:flutter/material.dart';
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/utils/constants.dart';
import 'package:little_birds/widgets/card_cell/card_cell_view_model.dart';

enum CardCellMode {
  list,
  deck,
}

typedef CardCallback = void Function(ThronesCard card);

class CardCell extends StatelessWidget {
  CardCell({
    Key key,
    @required this.viewModel,
    @required this.mode,
    @required this.onTap,
    this.count,
  })  : assert(viewModel != null),
        assert(mode != null),
        assert(onTap != null),
        super(key: key);

  final CardCellViewModel viewModel;
  final CardCellMode mode;
  final CardCallback onTap;
  final int count;

  final TextStyle _textStyleName = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  final TextStyle _textStyleQuantity = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  final TextStyle kTextStyleType = TextStyle(
    fontSize: 16.0,
    color: kColorGrayText,
  );

  Widget _widgetLeft() {
    return Container(
      width: 55.0,
      child: Center(
        child: Image.asset(
          viewModel.iconName(),
          height: 25.0,
        ),
      ),
    );
  }

  Widget _widgetMiddle() {
    final subtitle =
        mode == CardCellMode.deck ? viewModel.info() : viewModel.type();
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FittedBox(
            child: Text(
              viewModel.name(),
              style: _textStyleName,
            ),
          ),
          FittedBox(
            child: Text(
              subtitle,
              style: kTextStyleType,
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetRight() {
    return Container(
      width: 44.0,
      child: Center(
        child: Text(
          '$count',
          style: _textStyleQuantity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      color: Colors.white,
      child: RawMaterialButton(
        onPressed: () {
          onTap(viewModel.card);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _widgetLeft(),
            _widgetMiddle(),
            if (mode == CardCellMode.deck) _widgetRight(),
          ],
        ),
      ),
    );
  }
}

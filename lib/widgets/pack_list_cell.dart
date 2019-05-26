import 'package:flutter/material.dart';
import 'package:little_birds/model/pack.dart';
import 'package:little_birds/utils/constants.dart';

class PackListCell extends StatelessWidget {
  PackListCell({
    Key key,
    @required this.pack,
  })  : assert(pack != null),
        super(key: key);

  final Pack pack;

  TextStyle _textStyleName = TextStyle(
    fontSize: 20.0,
    color: Colors.black,
  );

  TextStyle _textStyleText = TextStyle(
    fontSize: 14.0,
    color: kColorGrayText,
  );

  Widget _widgetName() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          pack.name,
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
          style: _textStyleText,
        ),
      ),
    );
  }

  String _getStringCycle() {
    return 'Cycle: ${pack.cyclePosition} - ${pack.position}';
  }

  String _getStringNumber() {
    return pack.known < pack.total ? '${pack.known}/${pack.total} cards' : '${pack.total} cards';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _widgetName(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _widgetText(_getStringCycle()),
            _widgetText(_getStringNumber()),
          ],
        )
      ],
    );
  }
}

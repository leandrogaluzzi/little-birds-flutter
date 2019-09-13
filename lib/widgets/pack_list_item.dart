import 'package:flutter/material.dart';
import 'package:little_birds/model/thrones_pack.dart';
import 'package:little_birds/utils/constants.dart';

class PackListItem extends StatelessWidget {
  PackListItem({
    Key key,
    @required this.pack,
    @required this.index,
    @required this.onTap,
  })  : assert(pack != null),
        assert(index != null),
        super(key: key);

  final ThronesPack pack;
  final int index;
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
          style: TextStyle(
            fontSize: 16.0,
            color: kColorGrayText,
          ),
        ),
      ),
    );
  }

  String _getStringCycle() {
    return 'Cycle: ${pack.cyclePosition} - ${pack.position}';
  }

  String _getStringNumber() {
    return pack.known < pack.total
        ? '${pack.known}/${pack.total} cards'
        : '${pack.total} cards';
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
                _widgetText(_getStringCycle()),
                _widgetText(_getStringNumber()),
              ],
            )
          ],
        ),
      ),
    );
  }
}

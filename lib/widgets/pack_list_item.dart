import 'package:flutter/material.dart';
import 'package:little_birds/model/pack.dart';
import 'package:little_birds/utils/style.dart';

class PackListItem extends StatelessWidget {
  PackListItem({
    Key key,
    @required this.pack,
    @required this.index,
    @required this.onTap,
  })  : assert(pack != null),
        assert(index != null),
        super(key: key);

  final Pack pack;
  final int index;
  final VoidCallback onTap;

  final TextStyle _textStyleName = TextStyle(
    fontSize: 22.0,
    color: Colors.black,
    fontWeight: FontWeight.bold,
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
          style: kTextStyleGreySmall,
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
      color: index % 2 == 0 ? Colors.white : Colors.grey[200],
      height: 80.0,
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

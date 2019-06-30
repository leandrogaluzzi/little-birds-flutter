import 'package:flutter/material.dart';
import 'package:zoomable_image/zoomable_image.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen({
    Key key,
    @required this.url,
  })  : assert(url != null),
        super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dismissible(
        onDismissed: (DismissDirection direction) {
          Navigator.of(context).pop();
        },
        key: Key('ImageScreen'),
        direction: DismissDirection.vertical,
        child: ZoomableImage(
          NetworkImage(url),
          maxScale: 3.0,
          minScale: 1.0,
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

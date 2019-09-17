import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen({
    Key key,
    @required this.url,
  })  : assert(url != null),
        super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (DismissDirection direction) {
        Navigator.of(context).pop();
      },
      key: Key('ImageScreen'),
      direction: DismissDirection.vertical,
      child: PhotoView(
        imageProvider: NetworkImage(url),
        onTapUp: (context, details, value) {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

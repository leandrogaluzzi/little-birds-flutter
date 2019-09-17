import 'package:flutter/material.dart';
import 'package:little_birds/core/api/thrones_service.dart';

class ThronesServiceContainer extends InheritedWidget {
  final ThronesService thronesService;

  ThronesServiceContainer({
    Key key,
    @required this.thronesService,
    @required Widget child,
  })  : assert(thronesService != null),
        super(key: key, child: child);

  static ThronesServiceContainer of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ThronesServiceContainer)
        as ThronesServiceContainer;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

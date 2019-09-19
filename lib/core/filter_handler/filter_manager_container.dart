import 'package:flutter/material.dart';
import 'package:little_birds/core/filter_handler/filter_manager.dart';

class FilterManagerContainer extends InheritedWidget {
  final FilterManager filterManager;

  FilterManagerContainer({
    Key key,
    @required this.filterManager,
    @required Widget child,
  })  : assert(filterManager != null),
        super(key: key, child: child);

  static FilterManagerContainer of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(FilterManagerContainer)
        as FilterManagerContainer;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

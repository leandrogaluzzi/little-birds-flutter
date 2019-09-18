import 'package:flutter/widgets.dart';
import 'package:little_birds/pages/home/home_view_model.dart';

class HomeProvider extends InheritedWidget {
  final HomeViewModel viewModel;

  HomeProvider({
    Key key,
    @required this.viewModel,
    @required Widget child,
  })  : assert(viewModel != null),
        super(key: key, child: child);

  static HomeProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(HomeProvider) as HomeProvider;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

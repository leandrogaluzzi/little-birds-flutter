import 'package:flutter/material.dart';
import 'package:little_birds/core/cards_store/cards_store.dart';

class CardsStoreContainer extends InheritedWidget {
  final CardsStore cardsStore;

  CardsStoreContainer({
    Key key,
    @required this.cardsStore,
    @required Widget child,
  })  : assert(cardsStore != null),
        super(key: key, child: child);

  static CardsStoreContainer of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(CardsStoreContainer) as CardsStoreContainer;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:little_birds/cards_store.dart';
import 'package:little_birds/core/api/thrones_service.dart';
import 'package:little_birds/core/secure_storage/secure_storage.dart';

class Services extends InheritedWidget {
  Services({
    Key key,
    @required this.cardsStore,
    @required this.thronesService,
    @required this.secureStorage,
    @required Widget child,
  })  : assert(cardsStore != null),
        assert(thronesService != null),
        assert(secureStorage != null),
        super(key: key, child: child);

  final CardsStore cardsStore;
  final ThronesService thronesService;
  final SecureStorage secureStorage;

  static Services of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(Services) as Services;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

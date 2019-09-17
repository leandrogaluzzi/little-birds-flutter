import 'package:flutter/material.dart';
import 'package:little_birds/core/secure_storage/secure_storage.dart';

class SecureStorageContainer extends InheritedWidget {
  final SecureStorage secureStorage;

  SecureStorageContainer({
    Key key,
    @required this.secureStorage,
    @required Widget child,
  })  : assert(secureStorage != null),
        super(key: key, child: child);

  static SecureStorageContainer of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(SecureStorageContainer)
        as SecureStorageContainer;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

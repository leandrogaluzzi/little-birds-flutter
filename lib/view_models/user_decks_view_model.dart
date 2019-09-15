import 'package:flutter/widgets.dart';
import 'package:little_birds/core/api/thrones_service.dart';
import 'package:little_birds/core/secure_storage/secure_storage.dart';
import 'package:little_birds/model/auth.dart';

class UserDecksViewModel {
  UserDecksViewModel({
    @required this.thrones,
    @required this.storage,
  })  : assert(thrones != null),
        assert(storage != null);

  final ThronesService thrones;
  final SecureStorage storage;

  Future<Auth> auth({String code}) async {
    final auth = await thrones.authToken(code: code);
    return auth;
  }
}

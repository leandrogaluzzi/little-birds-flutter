import 'package:flutter/widgets.dart';
import 'package:little_birds/core/api/thrones_service.dart';
import 'package:little_birds/model/auth.dart';

class UserDecksViewModel {
  UserDecksViewModel({
    @required this.thrones,
  }) : assert(thrones != null);

  final ThronesService thrones;

  Future<Auth> auth({String code}) async {
    final auth = await thrones.authToken(code: code);
    return auth;
  }
}

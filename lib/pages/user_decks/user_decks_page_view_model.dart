import 'package:flutter/widgets.dart';
import 'package:little_birds/core/api/thrones_service.dart';
import 'package:little_birds/core/secure_storage.dart';
import 'package:little_birds/model/auth.dart';
import 'package:little_birds/model/thrones_deck.dart';

class UserDecksPageViewModel {
  UserDecksPageViewModel({
    @required this.thrones,
    @required this.storage,
  })  : assert(thrones != null),
        assert(storage != null);

  final ThronesService thrones;
  final SecureStorage storage;

  auth({Uri uri}) async {
    String code = uri.queryParameters['code'];
    final auth = await thrones.authToken(code: code);
    storage.saveAuth(auth);
  }

  Future<List<ThronesDeck>> userDecks() async {
    Auth auth = await storage.getAuth();
    final decks = await thrones.userDecks(accessToken: auth.accessToken);
    return decks;
  }

  refreshAuth() async {
    Auth auth = await storage.getAuth();
    final newAuth = await thrones.refreshToken(auth.refreshToken);
    storage.saveAuth(newAuth);
  }

  Future<Auth> getAuth() async {
    Auth auth = await storage.getAuth();
    return auth;
  }
}
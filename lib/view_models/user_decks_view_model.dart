import 'package:flutter/widgets.dart';
import 'package:little_birds/core/api/thrones_service.dart';
import 'package:little_birds/core/secure_storage/secure_storage.dart';
import 'package:little_birds/model/auth.dart';
import 'package:little_birds/model/thrones_deck.dart';

class UserDecksViewModel {
  UserDecksViewModel({
    @required this.thrones,
    @required this.storage,
  })  : assert(thrones != null),
        assert(storage != null);

  final ThronesService thrones;
  final SecureStorage storage;

  bool isAuthenticated() {
    return true;
  }

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
}

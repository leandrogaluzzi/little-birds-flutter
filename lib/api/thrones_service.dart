import 'package:little_birds/api/thrones_constants.dart';
import 'package:little_birds/network/network_provider.dart';
import 'thrones_api.dart';
import 'package:http/http.dart' as http;
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/model/thrones_pack.dart';
import 'package:little_birds/model/thrones_deck.dart';

class ThronesService {
  ThronesService() {
    http.Client client = http.Client();
    final networkProvider = DefaultNetworkProvider(
      client: client,
      baseUrl: ThronesConstants.baseURL,
    );

    _thrones = DefaultThrones(network: networkProvider);
  }

  DefaultThrones _thrones;

  Future<List<ThronesCard>> getCards() async {
    return _thrones.cards();
  }

  Future<List<ThronesPack>> getPacks() async {
    return _thrones.packs();
  }

  Future<List<ThronesDeck>> getDecks(DateTime date) async {
    return _thrones.decks(date: date);
  }
}

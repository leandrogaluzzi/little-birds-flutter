import 'network_provider.dart';
import 'thrones_api.dart';
import 'package:http/http.dart' as http;
import 'package:little_birds/model/thrones_card.dart';
import 'package:little_birds/model/thrones_pack.dart';
import 'package:little_birds/model/thrones_deck.dart';

const baseURL = 'https://thronesdb.com';

class ThronesService {
  ThronesService() {
    http.Client client = http.Client();
    final networkProvider = DefaultNetworkProvider(
      client: client,
      baseUrl: baseURL,
    );
    _thronesAPI = ThronesAPI(network: networkProvider);
  }

  ThronesAPI _thronesAPI;

  Future<List<ThronesCard>> getCards() async {
    return _thronesAPI.getCards();
  }

  Future<List<ThronesPack>> getPacks() async {
    return _thronesAPI.getPacks();
  }

  Future<List<ThronesDeck>> getDecks(DateTime date) async {
    return _thronesAPI.getDecks(date: date);
  }
}

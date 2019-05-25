import 'network_provider.dart';
import 'thrones_api.dart';
import 'package:http/http.dart' as http;
import 'package:little_birds/model/card.dart';
import 'package:little_birds/model/pack.dart';
import 'package:little_birds/model/deck.dart';

class ThronesService {
  ThronesService() {
    http.Client client = http.Client();
    NetworkProvider networkProvider = NetworkProvider(
      client: client,
      baseUrl: baseURL,
    );
    _thronesAPI = ThronesAPI(network: networkProvider);
  }

  ThronesAPI _thronesAPI;

  Future<List<CardItem>> getCards() async {
    return _thronesAPI.getCards();
  }

  Future<List<Pack>> getPacks() async {
    return _thronesAPI.getPacks();
  }

  Future<List<Deck>> getDecks(DateTime date) async {
    return _thronesAPI.getDecks(date: date);
  }
}

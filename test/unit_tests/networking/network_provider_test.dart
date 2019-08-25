import 'package:http/testing.dart';
import 'package:little_birds/networking/network_exception.dart';
import 'package:little_birds/networking/network_provider.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

String _baseUrl = 'mock.url';

void main() {
  test('Test response 200', () async {
    final mockResponse = 'response';
    http.Response response = http.Response(mockResponse, 200);

    final client = MockClient((request) async {
      return response;
    });

    final networkProvider =
        DefaultNetworkProvider(baseUrl: _baseUrl, client: client);

    String responseString;
    try {
      responseString = await networkProvider.get('test');
    } catch (e) {}
    expect(responseString, response.body);
  });

  test('Test response 400', () async {
    final mockResponse = 'response';
    http.Response response = http.Response(mockResponse, 400);

    final client = MockClient((request) async {
      return response;
    });

    final networkProvider =
        DefaultNetworkProvider(baseUrl: _baseUrl, client: client);

    expect(
        networkProvider.get('test'), throwsA(TypeMatcher<BadRequestError>()));
  });

  test('Test response 401', () {
    final mockResponse = 'response';
    http.Response response = http.Response(mockResponse, 401);

    final client = MockClient((request) async {
      return response;
    });

    final networkProvider =
        DefaultNetworkProvider(baseUrl: _baseUrl, client: client);

    expect(
        networkProvider.get('test'), throwsA(TypeMatcher<UnauthorisedError>()));
  });
  test('Test response 403', () {
    final mockResponse = 'response';
    http.Response response = http.Response(mockResponse, 403);

    final client = MockClient((request) async {
      return response;
    });

    final networkProvider =
        DefaultNetworkProvider(baseUrl: _baseUrl, client: client);

    expect(
        networkProvider.get('test'), throwsA(TypeMatcher<UnauthorisedError>()));
  });

  test('Test response 500', () {
    final mockResponse = 'response';
    http.Response response = http.Response(mockResponse, 500);

    final client = MockClient((request) async {
      return response;
    });

    final networkProvider =
        DefaultNetworkProvider(baseUrl: _baseUrl, client: client);

    expect(networkProvider.get('test'), throwsA(TypeMatcher<ServerError>()));
  });
  test('Test different response', () {
    final mockResponse = 'response';
    http.Response response = http.Response(mockResponse, 999);

    final client = MockClient((request) async {
      return response;
    });

    final networkProvider =
        DefaultNetworkProvider(baseUrl: _baseUrl, client: client);

    expect(networkProvider.get('test'), throwsA(TypeMatcher<FetchDataError>()));
  });
}

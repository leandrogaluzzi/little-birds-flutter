import 'package:flutter_test/flutter_test.dart';
import 'package:little_birds/networking/network_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

const urlTest = 'ttps://jsonplaceholder.typicode.com/posts/1';

main() {
  test('Network service should be able to do a get request', () async {
    String responseCreated = '{"id": "123"}';

    MockClient mockClient = MockClient((request) async {
      return http.Response(json.encode(responseCreated), 200);
    });

    NetworkProvider network = NetworkProvider(client: mockClient, baseUrl: "");
    dynamic responseReceived = await network.get(urlTest);

    expect(responseCreated, responseReceived);
  });

  test('Network service should return null for 404', () async {
    MockClient mockClient = MockClient((request) async {
      return http.Response(json.encode('{"id": "123"}'), 404);
    });

    NetworkProvider network = NetworkProvider(client: mockClient, baseUrl: "");
    String responseReceived = await network.get(urlTest);

    expect(responseReceived, null);
  });
}

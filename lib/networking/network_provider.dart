import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkProvider {
  NetworkProvider({
    @required this.client,
    @required this.baseUrl,
  })  : assert(client != null),
        assert(baseUrl != null),
        assert(baseUrl.isNotEmpty);

  final http.BaseClient client;
  final String baseUrl;

  Future<String> get(String url, {Map<String, String> headers, Map<String, String> parameters}) async {
    String fullUrl = baseUrl + url;
    http.Response response = await client.get(fullUrl, headers: headers);
    return response.body;
  }
}

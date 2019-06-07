import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkException extends Exception {
  factory NetworkException({int code}) => NetworkException(code: code);
  final int code;
}

class NetworkProvider {
  NetworkProvider({
    @required this.client,
    @required this.baseUrl,
  })  : assert(client != null),
        assert(baseUrl != null),
        assert(baseUrl.isNotEmpty);

  final http.BaseClient client;
  final String baseUrl;

  Future<String> get(String url,
      {Map<String, String> headers, Map<String, String> parameters}) async {
    String fullUrl = baseUrl + url;
    http.Response response = await client.get(fullUrl, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw NetworkException(code: response.statusCode);
    }
  }
}

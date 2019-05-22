import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkException extends Exception {
  factory NetworkException([var message]) => NetworkException(message);
}

class NetworkProvider {
  NetworkProvider({
    @required this.client,
    @required this.baseUrl,
  });
  final http.BaseClient client;
  final String baseUrl;

  Future<String> get(String url, {Map<String, String> headers}) async {
    String newUrl = baseUrl + url;

    try {
      http.Response response = await client.get(newUrl, headers: headers);

      if (response == null || response.body == null) {
        throw NetworkException('Bad Response');
      }
      
      int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 300) {
        throw NetworkException('Request error: $statusCode');
      }

      return response.body;
    } catch (e) {
      print('Exception Network Provider:/n${e.toString()}');
      throw NetworkException(e.toString());
    }
  }
}

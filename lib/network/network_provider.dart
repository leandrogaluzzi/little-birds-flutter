import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'network_exception.dart';

abstract class NetworkProvider {
  Future<String> get(String url,
      {Map<String, String> headers, Map<String, String> parameters});
}

class DefaultNetworkProvider extends NetworkProvider {
  DefaultNetworkProvider({
    @required this.client,
    @required this.baseUrl,
  })  : assert(client != null),
        assert(baseUrl != null),
        assert(baseUrl.isNotEmpty);

  final http.BaseClient client;
  final String baseUrl;

  @override
  Future<String> get(String url,
      {Map<String, String> headers, Map<String, String> parameters}) async {
    final uri = Uri.https(baseUrl, url, parameters);
    try {
      http.Response response = await client
          .get(uri, headers: headers)
          .timeout(Duration(seconds: 20));
      return _responseString(response: response);
    } on SocketException {
      throw NoConnectionError();
    } on TimeoutException {
      throw TimeoutError();
    }
  }

  String _responseString({http.Response response}) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
        throw BadRequestError(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedError(response.body.toString());
      case 500:
        throw ServerError(response.body.toString());
      default:
        throw FetchDataError(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

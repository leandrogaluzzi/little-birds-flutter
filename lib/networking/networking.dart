import 'package:http/http.dart' as http;

class NetworkException extends Exception {
  factory NetworkException([var message]) => Exception(message);
}

class Networking {
  Networking({this.baseUrl});

  final String baseUrl;

  Future<dynamic> get(String url, {Map<String, String> headers}) async {
    String fullUrl = baseUrl + url;

    try {
      http.Response response = await http.get(fullUrl, headers: headers);

      final statusCode = response.statusCode;
      final String body = response.body;

      if (statusCode < 200 || statusCode >= 300 || body == null) {
        throw NetworkException('Request error: $statusCode');
      }

      return body;
    } on Exception catch (e) {
      throw NetworkException(e.toString());
    }
  }
}

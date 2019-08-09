class NetworkException implements Exception {
  NetworkException([this._message, this._prefix]);

  final String _message;
  final String _prefix;

  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends NetworkException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends NetworkException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends NetworkException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class ServerErrorException extends NetworkException {
  ServerErrorException([message]) : super(message, "Server Error: ");
}

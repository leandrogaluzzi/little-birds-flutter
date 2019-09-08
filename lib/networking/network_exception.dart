class NetworkError implements Error {
  NetworkError([this._message, this._prefix]);

  final String _message;
  final String _prefix;

  String toString() {
    return '$_prefix$_message';
  }

  @override
  StackTrace get stackTrace => null;
}

class FetchDataError extends NetworkError {
  FetchDataError([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestError extends NetworkError {
  BadRequestError([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedError extends NetworkError {
  UnauthorisedError([message]) : super(message, "Unauthorised: ");
}

class ServerError extends NetworkError {
  ServerError([message]) : super(message, "Server Error: ");
}

class NoConnectionError extends NetworkError {
  NoConnectionError([message]) : super(message, "No Internet Connection: ");
}

class TimeoutError extends NetworkError {
  TimeoutError([message]) : super(message, "Timeout: ");
}

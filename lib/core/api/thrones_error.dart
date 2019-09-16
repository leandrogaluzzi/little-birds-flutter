import 'package:little_birds/core/network/network_error.dart';

class ThronesError extends NetworkError {
  ThronesError([message]) : super(message);
}

class ThronesAuthorizationError extends NetworkError {
  ThronesAuthorizationError([message]) : super(message);
}

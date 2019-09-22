import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:little_birds/model/auth.dart';

String _keyAcessToken = 'keyAccessToken';
String _keyRefreshToken = 'keyRefreshToken';

class SecureStorage with ChangeNotifier {
  SecureStorage() {
    _storage = FlutterSecureStorage();
  }

  FlutterSecureStorage _storage;

  saveAuth(Auth auth) async {
    await _storage.write(key: _keyAcessToken, value: auth.accessToken);
    await _storage.write(key: _keyRefreshToken, value: auth.refreshToken);
  }

  Future<Auth> getAuth() async {
    String accessToken = await _storage.read(key: _keyAcessToken);
    String refreshToken = await _storage.read(key: _keyRefreshToken);
    if (accessToken == null || refreshToken == null) {
      return null;
    }
    return Auth(accessToken: accessToken, refreshToken: refreshToken);
  }
}

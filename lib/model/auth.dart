class Auth {
  final String accessToken;
  final String refreshToken;

  Auth.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'],
        refreshToken = json['refresh_token'];
}

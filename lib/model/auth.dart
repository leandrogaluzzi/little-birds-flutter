class Auth {
  Auth({
    this.accessToken,
    this.refreshToken,
  })  : assert(accessToken != null),
        assert(refreshToken != null);

  final String accessToken;
  final String refreshToken;

  Auth.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'],
        refreshToken = json['refresh_token'];
}

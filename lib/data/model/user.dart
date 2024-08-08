// ignore_for_file: non_constant_identifier_names

class AuthTokenModel {
  final String access_token;
  final String refresh_token;
  final Duration expiry_time;
  final String token_type;

  factory AuthTokenModel.fromAPi(Map<String, dynamic> json) {
    return AuthTokenModel(
        access_token: json["access_token"],
        refresh_token: json["refresh_token"],
        expiry_time: Duration(seconds: json["expiry_time"]),
        token_type: json["token_type"]);
  }

  AuthTokenModel(
      {required this.access_token,
      required this.refresh_token,
      required this.expiry_time,
      required this.token_type});
}

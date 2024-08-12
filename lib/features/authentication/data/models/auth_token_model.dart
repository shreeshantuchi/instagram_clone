import 'package:login_token_app/features/authentication/domain/enitites/auth_token.dart';

class AuthTokenModel extends AuthToken {
  AuthTokenModel({
    required String accessToken,
    required String refreshToken,
    required Duration expiryTime,
    required String tokenType,
  }) : super(
          accessToken: accessToken,
          refreshToken: refreshToken,
          expiryTime: expiryTime,
          tokenType: tokenType,
        );

  factory AuthTokenModel.fromApi(Map<String, dynamic> json) {
    return AuthTokenModel(
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
      expiryTime: Duration(seconds: json["expiry_time"]),
      tokenType: json["token_type"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "access_token": accessToken,
      "refresh_token": refreshToken,
      "expiry_time": expiryTime.inSeconds,
      "token_type": tokenType,
    };
  }
}

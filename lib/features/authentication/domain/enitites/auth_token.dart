class AuthToken {
  final String accessToken;
  final String refreshToken;
  final Duration expiryTime;
  final String tokenType;

  AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.expiryTime,
    required this.tokenType,
  });
}

import 'package:login_token_app/features/authentication/data/models/auth_token_model.dart';
import 'package:login_token_app/core/services/ApiService/api_service.dart';
import 'package:login_token_app/core/services/sharedPreference/shared_preference_service.dart';
import 'package:login_token_app/core/constants/url/app_urls.dart';

abstract class AuthDataSource {
  Future<AuthTokenModel?> login(Map<String, dynamic> data);
  Future<void> cacheAuthToken(AuthTokenModel token);
  Future<AuthTokenModel?> getLastAuthToken();
  Future<void> clearAuthToken();
}

class AuthDataSourceImpl implements AuthDataSource {
  final ApiService apiService;
  final SharedPreferencesService sharedPreferencesService;

  AuthDataSourceImpl({
    required this.apiService,
    required this.sharedPreferencesService,
  });

  @override
  Future<AuthTokenModel?> login(Map<String, dynamic> data) async {
    final response =
        await apiService.sendPostRequest(data, baseUrl + loginEndpoint);
    if (response != null) {
      final token = AuthTokenModel.fromApi(response);
      await cacheAuthToken(token);
      return token;
    } else {
      throw Exception('Login failed');
    }
  }

  @override
  Future<void> cacheAuthToken(AuthTokenModel token) async {
    await sharedPreferencesService.saveAccessToken(token.accessToken);
    await sharedPreferencesService.saveRefreshToken(token.refreshToken);
  }

  @override
  Future<AuthTokenModel?> getLastAuthToken() async {
    final accessToken = await sharedPreferencesService.getAccessToken();
    final refreshToken = await sharedPreferencesService.getRefreshToken();
    if (accessToken != null && refreshToken != null) {
      return AuthTokenModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiryTime: Duration.zero,
        tokenType: 'Bearer',
      );
    }
    return null;
  }

  @override
  Future<void> clearAuthToken() async {
    await sharedPreferencesService.deleteTokens();
  }
}

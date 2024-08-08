import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_token_app/core/constants/client_detials.dart';
import 'package:login_token_app/core/constants/url/app_urls.dart';
import 'package:login_token_app/core/services/sharedPreference/shared_preference_service.dart';

class ApiService {
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  // ignore: body_might_complete_normally_nullable
  Future<Map<String, dynamic>?> sendPostRequest(
      Map<String, dynamic> data, String url) async {
    print(json.encode(data));
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    print(response.statusCode);

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> data = json.decode(response.body);
        return data;
      case 401:
        Map<String, dynamic>? newData = await refreshAccessToken();
        if (newData != null) {
          sendPostRequest(newData, url);
        } else {
          return null;
        }
        break;

      default:
        return null;
    }
  }

  Future<Map<String, dynamic>?> sendGetRequest(
      String accessToken, String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );
    print(response.statusCode);

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> data = json.decode(response.body);
        return data;
      case 401:
        Map<String, dynamic>? newData = await refreshAccessToken();
        if (newData != null) {
          print(newData);
          print("haha");
          sendGetRequest(newData["access_token"], url);
        } else {
          return null;
        }
        break;

      default:
        return null;
    }
    return null;
  }

  Future<Map<String, dynamic>?> refreshAccessToken() async {
    print("renewing accessToken");
    final refreshToken = await sharedPreferencesService.getRefreshToken();
    final response = await http.post(
      Uri.parse(baseUrl + renewRefreshTokenEndPoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "client_id": ClientDetials.clientId,
        "client_secret": ClientDetials.clientSecrets,
        "refresh_token": refreshToken,
        "grant_type": "refresh_token"
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final newAccessToken = json.decode(response.body)['access_token'];
      final newRefreshToken = json.decode(response.body)['refresh_token'];
      await sharedPreferencesService.saveAccessToken(newAccessToken);
      await sharedPreferencesService.saveRefreshToken(newRefreshToken);
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}

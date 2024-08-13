import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:login_token_app/core/constants/client_detials.dart';
import 'package:login_token_app/core/constants/url/app_urls.dart';
import 'package:login_token_app/core/services/sharedPreference/shared_preference_service.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:login_token_app/main.dart';

class ApiService {
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  // ignore: body_might_complete_normally_nullable
  Future<Map<String, dynamic>?> sendPostRequest(
      Map<String, dynamic> data, String url) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

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

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> data = json.decode(response.body);

        return data;
      case 401:
        Map<String, dynamic>? newData = await refreshAccessToken();
        if (newData != null) {
          sendGetRequest(
            newData["access_token"],
            url,
          );
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
    if (response.statusCode == 200) {
      final newAccessToken = json.decode(response.body)['access_token'];
      final newRefreshToken = json.decode(response.body)['refresh_token'];
      await sharedPreferencesService.saveAccessToken(newAccessToken);
      await sharedPreferencesService.saveRefreshToken(newRefreshToken);
      return json.decode(response.body);
    } else {
      BlocProvider.of<AuthBloc>(navigatorKey.currentState!.context)
          .add(const RefereshTokenExpiredEvent());
      return null;
    }
  }
}

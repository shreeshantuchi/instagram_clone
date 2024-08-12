import 'dart:convert';

import 'package:login_token_app/core/constants/url/app_urls.dart';
import 'package:login_token_app/core/services/ApiService/api_service.dart';
import 'package:login_token_app/core/services/sharedPreference/shared_preference_service.dart';
import 'package:login_token_app/features/feed/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class FeedRemoteDataSoruce {
  Future<List<PostModel>> getFeed();
}

class FeedRemoteDataSourceImpl implements FeedRemoteDataSoruce {
  final http.Client client;
  FeedRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getFeed() async {
    SharedPreferencesService sharedPreferencesService =
        SharedPreferencesService();
    ApiService apiService = ApiService();
    final accessToken = await sharedPreferencesService.getAccessToken();
    List postList = [];

    final response =
        await apiService.sendGetRequest(accessToken!, baseUrl + feedEndPpoint);
    if (response != null) {
      // print(response["data"]);
      // List val =
      //     response["data"]! as List;
      // print(val);

      List data = response["data"] as List;
      for (var element in data) {
        List data = element["products"];
        for (var item in data) {
          List<String?> imageList = [];
          List image = item["images"];

          for (var images in image) {
            imageList.add(images["image"]);
            item["imageList"] = imageList;
          }

          postList.add(item);
        }
      }

      final productModelList =
          postList.map((json) => PostModel.fromJson(json)).toList();
      return productModelList;
    } else {
      throw Exception("response is null");
    }
  }
}

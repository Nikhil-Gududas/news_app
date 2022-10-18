import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_model.dart';
import 'package:news_app/repo/api_status.dart';

class NewsServices {
  static final apiKey = dotenv.env['API_KEY'] ?? 'Api Key not found';
  static getNews() async {
    http.Client client = http.Client();
    Map<String, String> headers = {
      "X-Api-Key": apiKey,
      "Content-Type": "application/json"
    };
    Uri uri = Uri.parse("https://newsapi.org/v2/top-headlines?country=us");
    var response = await client.get(uri, headers: headers);
    List<NewsModel> news = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data['articles'].forEach((e) {
        news.add(NewsModel.fromJson(e));
      });
      return news;
    }
  }

  static Future<Object> getTopHeadlinesNews(String country) async {
    try {
      http.Client client = http.Client();
      Map<String, String> headers = {
        "X-Api-Key": apiKey,
        "Content-Type": "application/json"
      };
      Uri uri =
          Uri.parse("https://newsapi.org/v2/top-headlines?country=$country");
      var response = await client.get(uri, headers: headers);
      if (response.statusCode == 200) {
        // print("success");
        // print(jsonDecode(response.body));
        return Success(
            code: 200, response: newsResponseFromJson(response.body));
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } on HttpException {
      return Failure(code: 101, errorResponse: "No Internet Connection");
    } on SocketException {
      return Failure(code: 101, errorResponse: "No Internet Connection");
    } on FormatException {
      return Failure(code: 102, errorResponse: "Invalid Format");
    } catch (e) {
      // print(e);
      return Failure(code: 103, errorResponse: "Unknown Error");
    }
  }
}

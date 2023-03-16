import 'dart:convert';

import 'package:daily_news_app/constants.dart';
import 'package:daily_news_app/models/news_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<NewsModel> news = [];

  Future<void> getNews() async {
    String url = 'https://newsapi.org/v2/everything?q=all&apiKey=$API_KEY';

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach(
        (element) {
          if (element['urlToImage'] != null && element["description"] != null) {
            NewsModel newsModel = NewsModel(
              title: element["title"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
            );

            news.add(newsModel);
          }
        },
      );
    }
  }

  Future<void> getCategoryNews(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=$category&apiKey=$API_KEY';

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach(
        (element) {
          if (element['urlToImage'] != null && element["description"] != null) {
            NewsModel newsModel = NewsModel(
              title: element["title"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
            );

            news.add(newsModel);
          }
        },
      );
    }
  }

  Future<void> getSearchNews(String search) async {
    String url = 'https://newsapi.org/v2/everything?q=$search&apiKey=$API_KEY';

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach(
        (element) {
          if (element['urlToImage'] != null && element["description"] != null) {
            NewsModel newsModel = NewsModel(
              title: element["title"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
            );

            news.add(newsModel);
          }
        },
      );
    }
  }
}

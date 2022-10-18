import 'package:flutter/cupertino.dart';
import '../models/news_model.dart';
import '../models/news_error.dart';
import '../repo/api_status.dart';
import '../repo/news_services.dart';

class NewsViewModel extends ChangeNotifier {
  bool _isLoading = false;
  NewsModel? _news;
  NewsError? _newsError;
  bool get isLoading => _isLoading;
  NewsModel? get news => _news;
  NewsError? get newsError => _newsError;

  NewsViewModel() {
    getNews();
  }

  setLoading(bool isLoading) async {
    _isLoading = isLoading;
    notifyListeners();
  }

  setNews(NewsModel news) {
    List<Article> articles = [];
    for (var element in news.articles!) {
      if (element.description != null && element.urlToImage != null) {
        articles.add(element);
      }
    }
    news.articles = articles;
    _news = news;
  }

  setNewsError(NewsError newsError) {
    _newsError = newsError;
  }

  getNews() async {
    setLoading(true);
    var response = await NewsServices.getTopHeadlinesNews('in');
    if (response is Success) {
      setNews(response.response as NewsModel);
    }
    if (response is Failure) {
      NewsError newsError =
          NewsError(code: response.code, message: response.errorResponse);
      setNewsError(newsError);
    }
    setLoading(false);
  }
}

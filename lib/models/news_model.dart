import 'dart:convert';

NewsModel newsResponseFromJson(String str) =>
    NewsModel.fromJson(json.decode(str));

String newsResponseToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final int totalResults;
  List<Article>? articles;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles!.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    required this.source,
    this.author,
    required this.title,
    required this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  final Source source;
  String? author;
  final String title;
  final String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] ?? "NA",
        title: json["title"] ?? "NA",
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"] ?? "NA",
        content: json["content"] ?? "NA",
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toString(),
        "content": content,
      };
}

class Source {
  Source({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] ?? "NA",
        name: json["name"] ?? "NA",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

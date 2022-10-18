import 'package:flutter/material.dart';
import 'package:news_app/view/news_web_view.dart';
import '../models/news_model.dart';
import '../utils/constants.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key, required this.news}) : super(key: key);
  final Article news;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: Image.network(
              news.urlToImage ??
                  'https://us.123rf.com/450wm/pavelstasevich/pavelstasevich1811/pavelstasevich181101029/112815932-no-image-available-icon-flat-vector-illustration.jpg?ver=6',
              fit: BoxFit.cover,
            )),
        Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    news.title,
                    style: titleStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    news.description!,
                    style: body,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  ArticleView(postUrl: news.url!))));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text('author: ${news.author}')),
                        Text('source: ${news.source.name}'),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }
}

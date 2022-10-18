import 'package:flutter/material.dart';
import 'package:news_app/models/category.dart';
import '../utils/constants.dart';
import '../view_model/news_view_model.dart';
import './news_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final categories = CategoryModel.getCategories();
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    NewsViewModel newsViewModel = context.watch<NewsViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "News App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey.shade900,
        elevation: 0,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var e in categories)
                Container(
                  margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  height: 60,
                  width: double.infinity,
                  child: Stack(children: [
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Image.network(
                        e.imageAssetUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.grey.withOpacity(0.2)
                          ],
                        ),
                      ),
                      child: Center(
                          child:
                              Text(e.categoryName, style: categoryTextStyle)),
                    )
                  ]),
                ),
            ],
          ),
        ),
      ),
      body: _newsPage(newsViewModel),
    );
  }

  Widget _newsPage(NewsViewModel newsViewModel) {
    if (newsViewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (newsViewModel.newsError != null) {
      return Center(child: Text(newsViewModel.newsError!.message.toString()));
    }
    if (newsViewModel.news?.articles != null) {
      return SafeArea(
        child: RefreshIndicator(
          displacement: 60,
          strokeWidth: 1,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          color: Colors.black,
          onRefresh: () async {
            print("\nReloading...............................");
            newsViewModel.getNews();
          },
          child: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: newsViewModel.news!.articles!.length,
            itemBuilder: (context, index) =>
                NewsPage(news: newsViewModel.news!.articles![index]),
          ),
        ),
      );
    }
    return Container(
      color: Colors.red,
    );
  }
}

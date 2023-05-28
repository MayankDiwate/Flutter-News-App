import 'package:daily_news_app/models/category_model.dart';
import 'package:daily_news_app/models/news_model.dart';
import 'package:daily_news_app/screens/category_screen.dart';
import 'package:daily_news_app/utils/news.dart';
import 'package:daily_news_app/utils/utils.dart';
import 'package:daily_news_app/widgets/category_tile.dart';
import 'package:daily_news_app/widgets/news_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<NewsModel> news = <NewsModel>[];

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    news = newsClass.news;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/logo.png', height: 60, width: 150),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
            icon: const Icon(Icons.search, color: Colors.black, size: 30),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (_, i) {
                        return CategoryTile(
                          categoryName: categories[i].categoryName,
                          imageUrl: categories[i].imageUrl,
                          onTap: () => nextPage(
                            context,
                            CategoryScreen(
                                categoryName: categories[i].categoryName),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: news.length,
                      itemBuilder: (_, i) {
                        return NewsTile(
                          url: news[i].url,
                          description: news[i].description,
                          imageUrl: news[i].urlToImage,
                          title: news[i].title,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  final searchResults = [
    "food",
    "education",
    "technology",
    "china",
    "russia",
    "cricket",
    "lifestyle"
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final news = News();
    return FutureBuilder(
        future: news.getSearchNews(query),
        builder: (context, snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListView.builder(
              itemCount: news.news.length,
              shrinkWrap: true,
              itemBuilder: (_, i) {
                return NewsTile(
                  description: news.news[i].description,
                  imageUrl: news.news[i].urlToImage,
                  title: news.news[i].title,
                  url: news.news[i].url,
                );
              },
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where(
      (searchResult) {
        final resuts = searchResult.toLowerCase();
        final input = query.toLowerCase();

        return resuts.contains(input);
      },
    ).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (_, i) {
        return ListTile(
          title: Text(suggestions[i]),
          onTap: () {
            query = suggestions[i];
            showResults(context);
          },
        );
      },
    );
  }
}

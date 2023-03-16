import 'package:daily_news_app/models/news_model.dart';
import 'package:daily_news_app/utils/news.dart';
import 'package:daily_news_app/widgets/news_tile.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.categoryName});

  final String categoryName;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<NewsModel> news = <NewsModel>[];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    News newClass = News();
    await newClass.getCategoryNews(widget.categoryName);
    news = newClass.news;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.categoryName,
              style: const TextStyle(color: Colors.blue),
            ),
            const Text(" News", style: TextStyle(color: Colors.black)),
            const SizedBox(width: 60),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: size.height,
              width: size.width,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: news.length,
                itemBuilder: (_, i) {
                  return NewsTile(
                    description: news[i].description,
                    imageUrl: news[i].urlToImage,
                    title: news[i].title,
                    url: news[i].url,
                  );
                },
              ),
            ),
    );
  }
}

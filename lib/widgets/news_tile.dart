import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_news_app/screens/news_screen.dart';
import 'package:daily_news_app/utils/utils.dart';
import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  const NewsTile(
      {super.key,
      required this.description,
      required this.imageUrl,
      required this.title,
      required this.url});

  final String imageUrl, title, description, url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => nextPage(context, NewsScreen(newsUrl: url)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(imageUrl: imageUrl),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 5),
            Text(description,
                style: const TextStyle(fontSize: 14, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}

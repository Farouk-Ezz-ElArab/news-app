import 'package:flutter/material.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsBottomSheet extends StatelessWidget {
  News selectedNews;

  NewsBottomSheet({super.key, required this.selectedNews, required this.url});

  Uri url;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(width * 0.02),
            child: Image.network(
              selectedNews.urlToImage ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: height * 0.25,
                  color: Colors.grey.shade300,
                  child: const Icon(
                      Icons.broken_image, size: 50, color: Colors.grey),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: height * 0.25,
                  color: Colors.grey.shade200,
                  child: const Center(
                      child: CircularProgressIndicator(color: Colors.grey,)),
                );
              },
            ),
          ),
          SizedBox(height: height * 0.01),
          Expanded(
            child: Text(
              selectedNews.content!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: _launchUrl,
            child: Text(
              AppLocalizations.of(context)!.view_full_articel,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          SizedBox(height: height * 0.01),
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

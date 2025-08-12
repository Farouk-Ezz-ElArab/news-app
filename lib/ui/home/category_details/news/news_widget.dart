import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/ui/home/category_details/news/news_bottom_sheet.dart';
import 'package:news_app/ui/home/category_details/news/news_item.dart';
import 'package:news_app/utils/app_colors.dart';

import '../../../../model/SourceResponse.dart';

class NewsWidget extends StatefulWidget {
  Source source;

  NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder<NewsResponse?>(
      future: ApiManager.getNewsBySourceId(widget.source.id ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.greyColor),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.something_went_wrong,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greyColor,
                  ),
                  onPressed: () {
                    ApiManager.getNewsBySourceId(widget.source.id ?? '');
                    setState(() {});
                  },
                  child: Text(
                    AppLocalizations.of(context)!.try_again,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          );
        }
        if (snapshot.data?.status != 'ok') {
          return Center(
            child: Column(
              children: [
                Text(
                  snapshot.data!.message!,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greyColor,
                  ),
                  onPressed: () {
                    ApiManager.getNewsBySourceId(widget.source.id ?? '');
                    setState(() {});
                  },
                  child: Text(
                    AppLocalizations.of(context)!.try_again,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          );
        }
        var newsList = snapshot.data?.articles ?? [];
        return ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                showCustomBottomSheet(newsList[index]);
              },
              child: NewsItem(news: newsList[index]),
            );
          },
          itemCount: newsList.length,
        );
      },
    );
  }

  void showCustomBottomSheet(News selectedNews) {
    var height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      builder: (context) {
        return NewsBottomSheet(
          selectedNews: selectedNews,
          url: Uri.parse(selectedNews.url!),
        );
      },
      backgroundColor: Theme.of(context).indicatorColor,
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../model/NewsResponse.dart';

class NewsItem extends StatelessWidget {
  News news;

  NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.02,
      ),
      padding: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.02,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).indicatorColor, width: 1),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: news.urlToImage ?? '',
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(color: AppColors.greyColor),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(height: height * 0.02),
          Text(news.title ?? '', style: Theme.of(context).textTheme.labelLarge),
          SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'by: ${news.author ?? ''}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              Text(
                news.publishedAt != null && news.publishedAt!.isNotEmpty
                    ? timeago.format(
                        DateTime.parse(news.publishedAt!).toLocal(),
                      )
                    : '',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

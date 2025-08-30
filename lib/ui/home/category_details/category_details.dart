import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/retrofit_services.dart';

import '../../../l10n/app_localizations.dart';
import '../../../model/category.dart';
import '../../../utils/app_colors.dart';
class CategoryDetails extends StatefulWidget {
  Category category;

  CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RetrofitServices(Dio()).getSources(
          ApiConstants.apiKey, widget.category.id),
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
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelMedium,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greyColor,
                  ),
                  onPressed: () {
                    RetrofitServices(Dio()).getSources(
                        ApiConstants.apiKey, widget.category.id);
                    setState(() {});
                  },
                  child: Text(
                    AppLocalizations.of(context)!.try_again,
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelMedium,
                  ),
                ),
              ],
            ),
          );
        }
        // if (snapshot.data?.status != 'ok') {
        //   return Center(
        //     child: Column(
        //       children: [
        //         Text(
        //           snapshot.data!.message!,
        //           style: Theme.of(context).textTheme.labelMedium,
        //         ),
        //         ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //             backgroundColor: AppColors.greyColor,
        //           ),
        //           onPressed: () {
        //             ApiManager.getSources(widget.category.id);
        //             setState(() {});
        //           },
        //           child: Text(
        //             AppLocalizations.of(context)!.try_again,
        //             style: Theme.of(context).textTheme.labelMedium,
        //           ),
        //         ),
        //       ],
        //     ),
        //   );
        // }
        // var sourcesList = snapshot.data?.sources ?? [];
        // return SourceTabWidget(sourcesList: sourcesList);
      },
    );
  }
}
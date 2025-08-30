import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/api/app_Exception.dart';
import 'package:news_app/api/dio_api_manger.dart';
import 'package:news_app/ui/home/category_details/sources/source_tab_widget.dart';

import '../../../l10n/app_localizations.dart';
import '../../../model/SourceResponse.dart';
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
    return FutureBuilder<SourceResponse?>(
      future: DioApiManager.getInstance().getSources(widget.category.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.greyColor),
          );
        } else if (snapshot.hasError) {
          String errorMessage;
          if (snapshot.error is DioException &&
              (snapshot.error as DioException).error is AppException) {
            errorMessage =
                ((snapshot.error as DioException).error as AppException)
                    .message;
          } else {
            errorMessage = snapshot.error.toString();
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  errorMessage,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greyColor,
                  ),
                  onPressed: () {
                    DioApiManager.getInstance().getSources(widget.category.id);
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
        } else if (snapshot.hasData) {
          var sourcesList = snapshot.data!.sources;
          if (sourcesList == null || sourcesList.isEmpty) {
            return Center(
              child: Text(
                'No Sources Found',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            );
          } else {
            return SourceTabWidget(sourcesList: sourcesList);
          }
        } else {
          return Center(
            child: Text(
              'starting to fetch data',
              style: Theme.of(context).textTheme.headlineLarge,
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

import 'package:flutter/material.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../model/category.dart';
import '../../../../providers/app_language_provider.dart';
import '../../../../providers/app_theme_provider.dart';

class CategoryItem extends StatelessWidget {
  Category category;
  int index;

  CategoryItem({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Stack(
      alignment: index % 2 == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(width * 0.07),
          child: Image.asset(category.image),
        ),
        Container(
          margin: EdgeInsets.all(height * 0.02),
          padding: EdgeInsets.only(
            left: index % 2 == 0 ? width * 0.02 : 0,
            right: index % 2 != 0 ? width * 0.02 : 0,
          ),
          width: width * 0.38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.5),
            color: AppColors.greyColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: index % 2 == 0
                ? TextDirection.ltr
                : TextDirection.rtl,
            children: [
              Text(
                AppLocalizations.of(context)!.view_all,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  index % 2 == 0
                      ? Icons.keyboard_arrow_right_rounded
                      : Icons.keyboard_arrow_left_rounded,
                  color: Theme.of(context).indicatorColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

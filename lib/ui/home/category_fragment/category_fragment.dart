import 'package:flutter/material.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/ui/home/category_fragment/widgets/category_item.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_language_provider.dart';
import '../../../providers/app_theme_provider.dart';

typedef OnViewAllClick = void Function(Category);

class CategoryFragment extends StatelessWidget {
  List<Category> categoriesList = [];
  OnViewAllClick onViewAllClick;

  CategoryFragment({super.key, required this.onViewAllClick});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    categoriesList = Category.getCategoriesList(
      themeProvider.appTheme == ThemeMode.dark,
      context,
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(
              context,
            )!.good_morning_here_is_some_news_for_you,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: height * 0.02),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onViewAllClick(categoriesList[index]);
                  },
                  child: CategoryItem(
                    category: categoriesList[index],
                    index: index,
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: height * 0.02),
              itemCount: 7,
            ),
          ),
        ],
      ),
    );
  }
}

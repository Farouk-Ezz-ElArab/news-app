import 'package:flutter/cupertino.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/utils/app_assets.dart';

class Category {
  String id;
  String title;
  String image;

  Category({required this.image, required this.id, required this.title});

  static List<Category> getCategoriesList(bool isDark, BuildContext context) {
    return [
      Category(
        image: isDark
            ? AppAssets.generalDarkImage
            : AppAssets.generalLightImage,
        id: 'general',
        title: AppLocalizations.of(context)!.general,
      ),
      Category(
        image: isDark
            ? AppAssets.businessDarkImage
            : AppAssets.businessLightImage,
        id: 'business',
        title: AppLocalizations.of(context)!.business,
      ),
      Category(
        image: isDark
            ? AppAssets.entertainmentDarkImage
            : AppAssets.entertainmentLightImage,
        id: 'entertainment',
        title: AppLocalizations.of(context)!.entertainment,
      ),
      Category(
        image: isDark ? AppAssets.healthDarkImage : AppAssets.healthLightImage,
        id: 'health',
        title: AppLocalizations.of(context)!.health,
      ),
      Category(
        image: isDark
            ? AppAssets.scienceDarkImage
            : AppAssets.scienceLightImage,
        id: 'science',
        title: AppLocalizations.of(context)!.science,
      ),
      Category(
        image: isDark
            ? AppAssets.technologyDarkImage
            : AppAssets.technologyLightImage,
        id: 'technology',
        title: AppLocalizations.of(context)!.technology,
      ),
      Category(
        image: isDark ? AppAssets.sportsDarkImage : AppAssets.sportsLightImage,
        id: 'sports',
        title: AppLocalizations.of(context)!.sports,
      ),
    ];
  }
}

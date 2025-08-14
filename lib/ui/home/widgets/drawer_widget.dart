import 'package:flutter/material.dart';
import 'package:news_app/ui/home/widgets/theme_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/app_language_provider.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import 'language_bottom_sheet.dart';

class DrawerWidget extends StatefulWidget {
  VoidCallback onBackHomeClick;

  DrawerWidget({super.key, required this.onBackHomeClick});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(width * 0.1),
      ),
      shadowColor: AppColors.blackColor,
      backgroundColor: AppColors.greyColor,
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        appBar: AppBar(
          toolbarHeight: height * 0.15,
          backgroundColor: AppColors.whiteColor,
          title: Text(
            AppLocalizations.of(context)!.news_app,
            style: AppStyles.bold24Black,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.02,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  widget.onBackHomeClick();
                },
                child: Row(
                  children: [
                    ImageIcon(
                      AssetImage(AppAssets.homeIcon),
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      AppLocalizations.of(context)!.go_to_home,
                      style: AppStyles.bold20White,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              Divider(color: AppColors.whiteColor, height: height * 0.03),
              Row(
                children: [
                  ImageIcon(
                    AssetImage(AppAssets.themeIcon),
                    color: AppColors.whiteColor,
                  ),
                  SizedBox(width: width * 0.02),
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: AppStyles.bold20White,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: height * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.012,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.whiteColor, width: 2),
                ),
                child: InkWell(
                  onTap: () {
                    showThemeBottomSheet();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        themeProvider.appTheme == ThemeMode.light
                            ? AppLocalizations.of(context)!.light
                            : AppLocalizations.of(context)!.dark,
                        style: AppStyles.medium20White,
                      ),
                      //Spacer(),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 35,
                        color: AppColors.whiteColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              Divider(color: AppColors.whiteColor, height: height * 0.03),
              Row(
                children: [
                  ImageIcon(
                    AssetImage(AppAssets.languageIcon),
                    color: AppColors.whiteColor,
                  ),
                  SizedBox(width: width * 0.02),
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: AppStyles.bold20White,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: height * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.012,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.whiteColor, width: 2),
                ),
                child: InkWell(
                  onTap: () {
                    showLanguageBottomSheet();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        languageProvider.appLanguage == 'en'
                            ? AppLocalizations.of(context)!.english
                            : AppLocalizations.of(context)!.arabic,
                        style: AppStyles.medium20White,
                      ),
                      //Spacer(),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 35,
                        color: AppColors.whiteColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}

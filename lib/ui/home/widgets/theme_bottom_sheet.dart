import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.03,
        horizontal: screenSize.width * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: themeProvider.appTheme == ThemeMode.dark
                ? getSelectedThemeItem(
                    theme: AppLocalizations.of(context)!.dark,
                  )
                : getUnselectedThemeItem(
                    theme: AppLocalizations.of(context)!.dark,
                  ),
          ),
          SizedBox(height: screenSize.height * 0.02),
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.light);
            },
            child: themeProvider.appTheme == ThemeMode.light
                ? getSelectedThemeItem(
                    theme: AppLocalizations.of(context)!.light,
                  )
                : getUnselectedThemeItem(
                    theme: AppLocalizations.of(context)!.light,
                  ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedThemeItem({required String theme}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(theme, style: AppStyles.bold20Black),
        Icon(Icons.check, color: AppColors.blackColor, size: 35),
      ],
    );
  }

  Widget getUnselectedThemeItem({required String theme}) {
    return Row(children: [Text(theme, style: AppStyles.bold20Grey)]);
  }
}

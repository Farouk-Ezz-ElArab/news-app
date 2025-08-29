import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:news_app/di/di_injectable.config.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/providers/app_language_provider.dart';
import 'package:news_app/providers/app_theme_provider.dart';
import 'package:news_app/ui/home/home_screen.dart';
import 'package:news_app/utils/app_routes.dart';
import 'package:news_app/utils/app_theme.dart';
import 'package:news_app/utils/my_bloc_observer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'di/di_injectable.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(SourceResponseAdapter());
  Hive.registerAdapter(SourceAdapter());
  Hive.registerAdapter(NewsResponseAdapter());
  Hive.registerAdapter(NewsAdapter());
  final documentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: themeProvider.appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeScreenRouteName,
      routes: {AppRoutes.homeScreenRouteName: (context) => HomeScreen()},
      locale: Locale(languageProvider.appLanguage),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
import 'package:news_app/model/NewsResponse.dart';

abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsErrorState extends NewsStates {
  final String errorMessage;

  NewsErrorState({required this.errorMessage});
}

class NewsSuccessState extends NewsStates {
  final List<News> newsList;
  final bool hasMore;

  NewsSuccessState({required this.newsList, required this.hasMore});
}

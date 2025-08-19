import 'package:bloc/bloc.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/NewsResponse.dart';

import 'news_states.dart';

class NewsViewModel extends Cubit<NewsStates> {
  NewsViewModel() : super(NewsInitialState());

  Future<List<News>> getPagedNews({
    required String sourceId,
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await ApiManager.getPagedNews(
        sourceId: sourceId,
        page: page,
        pageSize: pageSize,
      );

      if (response == null) {
        throw Exception("No response from server");
      }

      if (response.status != 'ok') {
        final errorMessage = response.message ?? "Unknown error";
        emit(NewsErrorState(errorMessage: errorMessage));
        throw Exception(errorMessage);
      }

      final articles = response.articles ?? [];

      emit(NewsSuccessState(newsList: articles, hasMore: articles.isNotEmpty));

      return articles;
    } catch (e) {
      emit(NewsErrorState(errorMessage: e.toString()));
      rethrow;
    }
  }
}

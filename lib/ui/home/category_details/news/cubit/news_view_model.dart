import 'package:bloc/bloc.dart';
import 'package:news_app/data/repository/news_paged/repository/news_repository_paged.dart';
import 'package:news_app/model/NewsResponse.dart';

import 'news_states.dart';

class NewsViewModel extends Cubit<NewsStates> {
  // late NewsRepository newsRepository;
  // late NewsRemoteDataSource newsRemoteDataSource;
  late NewsRepositoryPaged newsRepositoryPaged;

  // late NewsRemoteDataSourcePaged newsRemoteDataSourcePaged;
  // late ApiManager apiManager;
  NewsViewModel({required this.newsRepositoryPaged})
    : super(NewsInitialState());

  Future<List<News>> getPagedNews({
    required String sourceId,
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      emit(NewsLoadingState());
      final response = await newsRepositoryPaged.getPagedNews(
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

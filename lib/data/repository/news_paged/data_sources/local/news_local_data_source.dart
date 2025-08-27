import 'package:news_app/model/NewsResponse.dart';

abstract class NewsLocalDataSource {
  Future<NewsResponse?> getPagedNews({required String sourceId});

  void savePagedNews(NewsResponse? newsResponse, String categoryId);
}

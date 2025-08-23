import 'package:news_app/model/NewsResponse.dart';

abstract class NewsRemoteDataSourcePaged {
  Future<NewsResponse?> getPagedNews({required String sourceId});
}

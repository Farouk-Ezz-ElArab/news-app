import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';

abstract class NewsRepositoryPaged {
  Future<NewsResponse?> getPagedNews({
    required String sourceId,
    String searchQuery = '',
    String searchIn = '',
    int page = 1,
    int pageSize = 10,
  });
}

import '../../../../../model/NewsResponse.dart';
import '../../data_sources/remote/news_remote_data_source_paged.dart';
import '../news_repository_paged.dart';

class NewsRepositoryPagedImpl implements NewsRepositoryPaged {
  NewsRemoteDataSourcePaged newsRemoteDataSourcePaged;

  NewsRepositoryPagedImpl({required this.newsRemoteDataSourcePaged});

  @override
  Future<NewsResponse?> getPagedNews({
    required String sourceId,
    String searchQuery = '',
    String searchIn = '',
    int page = 1,
    int pageSize = 10,
  }) {
    return newsRemoteDataSourcePaged.getPagedNews(sourceId: sourceId);
  }
}

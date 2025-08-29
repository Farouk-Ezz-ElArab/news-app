import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/data/repository/news_paged/data_sources/local/news_local_data_source.dart';

import '../../../../../model/NewsResponse.dart';
import '../../data_sources/remote/news_remote_data_source_paged.dart';
import '../news_repository_paged.dart';

@Injectable(as: NewsRepositoryPaged)
class NewsRepositoryPagedImpl implements NewsRepositoryPaged {
  NewsRemoteDataSourcePaged newsRemoteDataSourcePaged;
  NewsLocalDataSource newsLocalDataSource;

  NewsRepositoryPagedImpl(
      {required this.newsRemoteDataSourcePaged, required this.newsLocalDataSource});

  @override
  Future<NewsResponse?> getPagedNews({
    required String sourceId,
    String searchQuery = '',
    String searchIn = '',
    int page = 1,
    int pageSize = 10,
  }) async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      var newsResponse = await newsRemoteDataSourcePaged.getPagedNews(
          sourceId: sourceId);
      newsLocalDataSource.savePagedNews(newsResponse, sourceId);
      return newsResponse;
    }
    else {
      var newsResponse = await newsLocalDataSource.getPagedNews(
          sourceId: sourceId);
      if (newsResponse == null) {
        throw Exception("No cached sources available");
      }
      return newsResponse;
    }
    //return newsRemoteDataSourcePaged.getPagedNews(sourceId: sourceId);
  }
}

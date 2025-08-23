import 'package:news_app/api/api_manager.dart';
import 'package:news_app/data/repository/news/data_sources/remote/news_remote_data_source.dart';
import 'package:news_app/data/repository/news_paged/data_sources/remote/news_remote_data_source_paged.dart';
import 'package:news_app/model/NewsResponse.dart';

class NewsRemoteDataSourcePagedImpl implements NewsRemoteDataSourcePaged {
  ApiManager apiManager;

  NewsRemoteDataSourcePagedImpl({required this.apiManager});

  @override
  Future<NewsResponse?> getPagedNews({required String sourceId}) async {
    return await apiManager.getPagedNews(sourceId: sourceId);
  }
}

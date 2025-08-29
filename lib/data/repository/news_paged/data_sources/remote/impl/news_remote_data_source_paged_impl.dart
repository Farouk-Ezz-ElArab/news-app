import 'package:injectable/injectable.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/data/repository/news_paged/data_sources/remote/news_remote_data_source_paged.dart';
import 'package:news_app/model/NewsResponse.dart';

@Injectable(as: NewsRemoteDataSourcePaged)
class NewsRemoteDataSourcePagedImpl implements NewsRemoteDataSourcePaged {
  ApiManager apiManager;

  NewsRemoteDataSourcePagedImpl({required this.apiManager});

  @override
  Future<NewsResponse?> getPagedNews({required String sourceId}) async {
    return await apiManager.getPagedNews(sourceId: sourceId);
  }
}

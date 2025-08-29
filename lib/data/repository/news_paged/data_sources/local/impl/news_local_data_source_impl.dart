import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/data/repository/news_paged/data_sources/local/news_local_data_source.dart';
import 'package:news_app/model/NewsResponse.dart';

@Injectable(as: NewsLocalDataSource)
class NewsLocalDataSourceImpl extends NewsLocalDataSource {
  @override
  Future<NewsResponse?> getPagedNews({required String sourceId}) async {
    var box = await Hive.openBox('newsTab');
    var newsTab = box.get(
      sourceId,
    ); //NewsResponse.fromJson(box.get(categoryId));
    return newsTab;
  }

  @override
  void savePagedNews(NewsResponse? newsResponse, String categoryId) async {
    var box = await Hive.openBox('newsTab');
    await box.put(categoryId, newsResponse); //?.toJson());
    await box.close();
  }
}

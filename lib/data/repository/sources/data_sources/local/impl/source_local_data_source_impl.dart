import 'package:hive/hive.dart';
import 'package:news_app/data/repository/sources/data_sources/local/source_local_data_source.dart';
import 'package:news_app/model/SourceResponse.dart';

class SourceLocalDataSourceImpl implements SourceLocalDataSource {
  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    var box = await Hive.openBox('SourceTab');
    var sourceTab = box.get(
      categoryId,
    ); //SourceResponse.fromJson(box.get(categoryId));
    return sourceTab;
  }

  @override
  void saveSources(SourceResponse? sourceResponse, String categoryId) async {
    var box = await Hive.openBox('SourceTab');
    await box.put(categoryId, sourceResponse); //?.toJson());
    await box.close();
  }
}

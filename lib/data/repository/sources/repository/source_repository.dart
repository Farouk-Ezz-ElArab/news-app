import 'package:news_app/model/SourceResponse.dart';

abstract class SourceRepository {
  Future<SourceResponse?> getSources(String categoryId);
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/end_points.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';

class ApiManager {
  Future<SourceResponse?> getSources(String categoryId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
      'apiKey': ApiConstants.apiKey,
      'category': categoryId,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return SourceResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  Future<NewsResponse?> getNewsBySourceId(
    String sourceId, {
    String searchQuery = '',
    String searchIn = '',
    int page = 1,
    int pageSize = 10,
  }) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
      'apiKey': ApiConstants.apiKey,
      'sources': sourceId,
      if (searchQuery.isNotEmpty) 'q': searchQuery,
      if (searchIn.isNotEmpty) 'searchIn': searchIn,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      //NewsResponse.fromJson(jsonDecode(response.body));
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  Future<NewsResponse?> getPagedNews({
    required String sourceId,
    String searchQuery = '',
    String searchIn = '',
    int page = 1,
    int pageSize = 10,
  }) async {
    var newsResponse = await getNewsBySourceId(
      sourceId,
      searchQuery: searchQuery,
      searchIn: searchIn,
      page: page,
      pageSize: pageSize,
    );

    return newsResponse;
  }
}

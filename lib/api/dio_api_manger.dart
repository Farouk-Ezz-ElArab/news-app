import 'package:dio/dio.dart';
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/app_Exception.dart';
import 'package:news_app/api/end_points.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioApiManager {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://newsapi.org',
      //queryParameters: {'apiKey': ApiConstants.apiKey},
    ),
  );

  DioApiManager._() {
    dio.interceptors.add(DioInterceptors());
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: true,
      ),
    );
  }

  static DioApiManager? _dioApiManager;

  static DioApiManager getInstance() {
    return _dioApiManager ??= DioApiManager._();
  }

  Future<SourceResponse?> getSources(String categoryId) async {
    try {
      var response = await dio.get(
        EndPoints.sourceApi,
        queryParameters: {
          'apiKey': ApiConstants.apiKey,
          'category': categoryId,
        },
      );
      var json = response.data;
      var sourceResponse = SourceResponse.fromJson(json);
      return sourceResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<NewsResponse?> getNewsBySourceId(
    String sourceId, {
    String searchQuery = '',
    String searchIn = '',
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      var response = await dio.get(
        EndPoints.newsApi,
        queryParameters: {'apiKey': ApiConstants.apiKey, 'sources': sourceId},
      );
      return NewsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<News>> getPagedNews({
    required String sourceId,
    String searchQuery = '',
    String searchIn = '',
    int page = 1,
    int pageSize = 10,
  }) async {
    final newsResponse = await DioApiManager._().getNewsBySourceId(
      sourceId,
      searchQuery: searchQuery,
      searchIn: searchIn,
      page: page,
      pageSize: pageSize,
    );

    return newsResponse?.articles ?? [];
  }
}

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    options.headers.addAll({'X-Api-Key': ApiConstants.apiKey});
    print('onRequest => ${options.baseUrl}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    print('onResponse => ${response.statusCode}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    String message = 'Something went wrong, Please try again';
    try {
      if (err.response != null &&
          err.response!.data is Map &&
          err.response!.data.containsKey('message')) {
        message = err.response!.data['message'];
      } else {
        //todo : fallback message for other bad response types
        switch (err.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.connectionError:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.sendTimeout:
            message =
                'Connection time out. Please check your internet connection.';
            break;
          case DioExceptionType.badResponse:
            message =
                'Failed to load data. status code: ${err.response?.statusCode}';
            break;

          case DioExceptionType.cancel:
            message = 'Request was cancelled. ';
            break;
          case DioExceptionType.unknown:
            message = 'An unknown network error occurred';
            break;

          default:
            message = 'An unknown error occurred';
            break;
        }
      }
    } catch (e) {
      //todo: if parsing fails , fall back to a generic message
      message = 'An unexpected error occurred : ${e.toString()}';
    }
    //super.onError(err, handler);
    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        message: message,
        error: AppException(message: message),
        type: err.type,
        response: err.response,
      ),
    );
  }
}

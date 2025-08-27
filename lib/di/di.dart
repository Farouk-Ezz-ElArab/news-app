import 'package:news_app/api/api_manager.dart';
import 'package:news_app/data/repository/news_paged/data_sources/local/impl/news_local_data_source_impl.dart';
import 'package:news_app/data/repository/news_paged/data_sources/local/news_local_data_source.dart';
import 'package:news_app/data/repository/news_paged/data_sources/remote/impl/news_remote_data_source_paged_impl.dart';
import 'package:news_app/data/repository/news_paged/data_sources/remote/news_remote_data_source_paged.dart';
import 'package:news_app/data/repository/news_paged/repository/impl/news_repository_paged_impl.dart';
import 'package:news_app/data/repository/sources/data_sources/local/impl/source_local_data_source_impl.dart';
import 'package:news_app/data/repository/sources/data_sources/local/source_local_data_source.dart';
import 'package:news_app/data/repository/sources/data_sources/remote/impl/source_remote_data_source_impl.dart';
import 'package:news_app/data/repository/sources/repository/impl/source_repository_impl.dart';

import '../data/repository/news_paged/repository/news_repository_paged.dart';
import '../data/repository/sources/data_sources/remote/source_remote_data_source.dart';
import '../data/repository/sources/repository/source_repository.dart';
SourceRepository injectSourceRepository() {
  return SourceRepositoryImpl(
    sourceLocalDataSource: injectSourceLocalDataSource(),
    sourceRemoteDataSource: injectSourceRemoteDataSource(),
  );
}

SourceLocalDataSource injectSourceLocalDataSource() {
  return SourceLocalDataSourceImpl();
}

SourceRemoteDataSource injectSourceRemoteDataSource() {
  return SourceRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}
NewsRepositoryPaged injectNewsRepositoryPaged() {
  return NewsRepositoryPagedImpl(
    newsLocalDataSource: injectNewsLocalDataSource(),
    newsRemoteDataSourcePaged: injectNewsRemoteDataSourcePaged(),
  );
}
NewsRemoteDataSourcePaged injectNewsRemoteDataSourcePaged() {
  return NewsRemoteDataSourcePagedImpl(apiManager: ApiManager.getInstance());
}

NewsLocalDataSource injectNewsLocalDataSource() {
  return NewsLocalDataSourceImpl();
}
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../api/api_manager.dart' as _i1047;
import '../data/repository/news_paged/data_sources/local/impl/news_local_data_source_impl.dart'
    as _i946;
import '../data/repository/news_paged/data_sources/local/news_local_data_source.dart'
    as _i293;
import '../data/repository/news_paged/data_sources/remote/impl/news_remote_data_source_paged_impl.dart'
    as _i268;
import '../data/repository/news_paged/data_sources/remote/news_remote_data_source_paged.dart'
    as _i917;
import '../data/repository/news_paged/repository/impl/news_repository_paged_impl.dart'
    as _i2;
import '../data/repository/news_paged/repository/news_repository_paged.dart'
    as _i336;
import '../data/repository/sources/data_sources/local/impl/source_local_data_source_impl.dart'
    as _i313;
import '../data/repository/sources/data_sources/local/source_local_data_source.dart'
    as _i316;
import '../data/repository/sources/data_sources/remote/impl/source_remote_data_source_impl.dart'
    as _i868;
import '../data/repository/sources/data_sources/remote/source_remote_data_source.dart'
    as _i567;
import '../data/repository/sources/repository/impl/source_repository_impl.dart'
    as _i250;
import '../data/repository/sources/repository/source_repository.dart' as _i522;
import '../ui/home/category_details/cubit/source_view_model.dart' as _i712;
import '../ui/home/category_details/news/cubit/news_view_model.dart' as _i686;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.factory<_i316.SourceLocalDataSource>(
      () => _i313.SourceLocalDataSourceImpl(),
    );
    gh.factory<_i293.NewsLocalDataSource>(
      () => _i946.NewsLocalDataSourceImpl(),
    );
    gh.factory<_i567.SourceRemoteDataSource>(
      () =>
          _i868.SourceRemoteDataSourceImpl(apiManager: gh<_i1047.ApiManager>()),
    );
    gh.factory<_i917.NewsRemoteDataSourcePaged>(
      () => _i268.NewsRemoteDataSourcePagedImpl(
        apiManager: gh<_i1047.ApiManager>(),
      ),
    );
    gh.factory<_i522.SourceRepository>(
      () => _i250.SourceRepositoryImpl(
        sourceRemoteDataSource: gh<_i567.SourceRemoteDataSource>(),
        sourceLocalDataSource: gh<_i316.SourceLocalDataSource>(),
      ),
    );
    gh.factory<_i712.SourceViewModel>(
      () =>
          _i712.SourceViewModel(sourceRepository: gh<_i522.SourceRepository>()),
    );
    gh.factory<_i336.NewsRepositoryPaged>(
      () => _i2.NewsRepositoryPagedImpl(
        newsRemoteDataSourcePaged: gh<_i917.NewsRemoteDataSourcePaged>(),
        newsLocalDataSource: gh<_i293.NewsLocalDataSource>(),
      ),
    );
    gh.factory<_i686.NewsViewModel>(
      () => _i686.NewsViewModel(
        newsRepositoryPaged: gh<_i336.NewsRepositoryPaged>(),
      ),
    );
    return this;
  }
}

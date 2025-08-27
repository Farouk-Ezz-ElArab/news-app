import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/data/repository/sources/data_sources/local/source_local_data_source.dart';
import 'package:news_app/data/repository/sources/data_sources/remote/source_remote_data_source.dart';
import 'package:news_app/data/repository/sources/repository/source_repository.dart';
import 'package:news_app/model/SourceResponse.dart';

@Injectable(as: SourceRepository)
class SourceRepositoryImpl implements SourceRepository {
  SourceRemoteDataSource sourceRemoteDataSource;
  SourceLocalDataSource sourceLocalDataSource;

  SourceRepositoryImpl(
      {required this.sourceRemoteDataSource, required this.sourceLocalDataSource});

  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      var sourceResponse = await sourceRemoteDataSource.getSources(categoryId);
      sourceLocalDataSource.saveSources(sourceResponse, categoryId);
      return sourceResponse;
    }
    else {
      var sourceResponse = await sourceLocalDataSource.getSources(categoryId);
      if (sourceResponse == null) {
        throw Exception("No cached sources available");
      }
      return sourceResponse;
    }
  }
}

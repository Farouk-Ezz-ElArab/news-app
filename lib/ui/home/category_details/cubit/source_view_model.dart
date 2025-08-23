import 'package:bloc/bloc.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/data/repository/sources/data_sources/remote/impl/source_remote_data_source_impl.dart';
import 'package:news_app/data/repository/sources/data_sources/remote/source_remote_data_source.dart';
import 'package:news_app/data/repository/sources/repository/impl/source_repository_impl.dart';
import 'package:news_app/data/repository/sources/repository/source_repository.dart';
import 'package:news_app/ui/home/category_details/cubit/sources_states.dart';

class SourceViewModel extends Cubit<SourcesStates> {
  late SourceRepository sourceRepository;

  // late SourceRemoteDataSource sourceRemoteDataSource;
  // late ApiManager apiManager;
  SourceViewModel({required this.sourceRepository})
    : super(SourceLoadingState());

  int index = 0;

  void changeSelectedIndex(int selectedIndex, String categoryId) async {
    try {
      index = selectedIndex;
      emit(SourceLoadingState());
      var response = await sourceRepository.getSources(categoryId);

      if (response?.status != 'ok') {
        emit(SourceErrorState(errorMessage: response!.message!));
      } else {
        emit(SourceChangedState());
      }
    } catch (e) {
      emit(SourceErrorState(errorMessage: e.toString()));
    }
  }

  void getSources(String categoryId) async {
    try {
      emit(SourceLoadingState());
      var response = await sourceRepository.getSources(categoryId);
      if (response?.status != 'ok') {
        emit(SourceErrorState(errorMessage: response!.message!));
      }
      if (response?.status == 'ok') {
        emit(SourceSuccessState(sourcesList: response!.sources!));
      }
    } catch (e) {
      emit(SourceErrorState(errorMessage: e.toString()));
    }
  }
}

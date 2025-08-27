// import 'package:bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/data/repository/sources/repository/source_repository.dart';
import 'package:news_app/ui/home/category_details/cubit/sources_states.dart';

@injectable
class SourceViewModel extends Cubit<SourcesStates> {
  late SourceRepository sourceRepository;

  // late SourceRemoteDataSource sourceRemoteDataSource;
  // late ApiManager apiManager;
  SourceViewModel({required this.sourceRepository})
    : super(SourceLoadingState());

  int index = 0;

  void changeSelectedIndex(int selectedIndex) {
    index = selectedIndex;
    emit(SourceChangedState());
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

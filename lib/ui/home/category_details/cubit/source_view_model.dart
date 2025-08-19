import 'package:bloc/bloc.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/ui/home/category_details/cubit/sources_states.dart';

class SourceViewModel extends Cubit<SourcesStates> {
  SourceViewModel() : super(SourceLoadingState());
  int index = 0;

  void changeSelectedIndex(int selectedIndex, String categoryId) async {
    try {
      index = selectedIndex;
      emit(SourceLoadingState());
      var response = await ApiManager.getSources(categoryId);

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
      var response = await ApiManager.getSources(categoryId);
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

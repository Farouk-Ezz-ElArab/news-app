import '../../../../model/SourceResponse.dart';

abstract class SourcesStates {}

class SourceLoadingState extends SourcesStates {}

class SourceErrorState extends SourcesStates {
  String errorMessage;

  SourceErrorState({required this.errorMessage});
}

class SourceSuccessState extends SourcesStates {
  List<Source> sourcesList;

  SourceSuccessState({required this.sourcesList});
}

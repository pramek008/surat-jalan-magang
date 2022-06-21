part of 'postreport_bloc.dart';

@immutable
abstract class PostreportState extends Equatable {}

class PostreportInitial extends PostreportState {
  @override
  List<Object> get props => [];
}

class PostreportLoadingState extends PostreportState {
  @override
  List<Object> get props => [];
}

class PostreportSuccessState extends PostreportState {
  final String response;

  PostreportSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class PostreportFailureState extends PostreportState {
  final ResponseModel response;

  PostreportFailureState(this.response);

  @override
  List<Object?> get props => [response];
}

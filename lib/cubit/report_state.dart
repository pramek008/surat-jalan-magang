part of 'report_cubit.dart';

@immutable
abstract class ReportState {}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportLoaded extends ReportState {
  final List<ReportModel> reports;

  ReportLoaded({
    required this.reports,
  });

  List<Object> get props => [reports];
}

class ReportError extends ReportState {
  final String message;

  ReportError({
    required this.message,
  });

  List<Object> get props => [message];
}

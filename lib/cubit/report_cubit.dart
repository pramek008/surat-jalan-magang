import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:surat_jalan/models/report_model.dart';
import 'package:surat_jalan/models/response_model.dart';

import '../services/report_service.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());

  void getAllReport() async {
    emit(ReportLoading());
    try {
      List<ReportModel> reports = await ReportService().getAllReport();
      emit(ReportLoaded(reports: reports));
    } catch (e) {
      emit(ReportError(message: e.toString()));
    }
  }

  void deleteReport(int reportId) async {
    emit(ReportLoading());
    try {
      ResponseModel response = await ReportService().deleteReport(reportId);
      emit(ReportResponse(response: response));
      ReportService().getAllReport();
    } catch (e) {
      emit(ReportError(message: e.toString()));
    }
  }
}

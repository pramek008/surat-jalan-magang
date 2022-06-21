import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
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

  void postReport(
      {required int userId,
      required int perintahJalanId,
      required String namaKegiatan,
      required List images,
      required List lokasi,
      required String deskripsi}) async {
    emit(ReportLoading());
    try {
      final response = await ReportService().postReport(
          userId: userId,
          perintahJalanId: perintahJalanId,
          namaKegiatan: namaKegiatan,
          images: images,
          lokasi: lokasi,
          deskripsi: deskripsi);
      emit(ReportResponse(
          response:
              ResponseModel(status: response, message: response.toString())));
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

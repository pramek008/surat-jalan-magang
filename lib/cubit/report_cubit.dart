import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:surat_jalan/models/report_model.dart';

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
}

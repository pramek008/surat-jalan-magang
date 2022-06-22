import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:surat_jalan/services/report_service.dart';

import '../models/response_model.dart';

part 'postreport_event.dart';
part 'postreport_state.dart';

class PostreportBloc extends Bloc<PostreportEvent, PostreportState> {
  PostreportBloc() : super(PostreportInitial()) {
    on<PostreportRequestedEvent>((event, emit) async {
      emit(PostreportLoadingState());
      try {
        final response = await ReportService().postReport(
            userId: event.userId,
            perintahJalanId: event.perintahJalanId,
            namaKegiatan: event.namaKegiatan,
            images: event.images,
            lokasi: event.lokasi,
            deskripsi: event.deskripsi);
        emit(PostreportSuccessState(response));
      } catch (e) {
        emit(PostreportFailureState(
            ResponseModel(message: e.toString(), status: '')));
      }
    });
  }
}

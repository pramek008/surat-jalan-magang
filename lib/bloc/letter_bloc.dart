import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/response_model.dart';
import '../services/letter_service.dart';

part 'letter_event.dart';
part 'letter_state.dart';

class LetterBloc extends Bloc<LetterEvent, LetterState> {
  LetterBloc() : super(LetterInitial()) {
    on<LetterPutEvent>((event, emit) async {
      emit(LetterLoadingState());
      try {
        final response = await LetterService().putLetter(
          id: event.id,
          userId: event.userId,
          judul: event.judul,
          nomorSurat: event.nomorSurat,
          pemberiPerintah: event.pemberiPerintah,
          anggotaMengikuti: event.anggotaMengikuti,
          lokasiTujuan: event.lokasiTujuan,
          keterangan: event.keterangan,
          tglAwal: event.tglAwal,
          tglAkhir: event.tglAkhir,
          diserahkan: event.diserahkan,
        );
        emit(LetterSuccessState(response));
      } catch (e) {
        emit(LetterFailureState(
            ResponseModel(message: e.toString(), status: '')));
      }
    });
  }
}

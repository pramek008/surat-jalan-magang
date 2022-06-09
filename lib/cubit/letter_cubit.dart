import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:surat_jalan/models/letter_model.dart';
import 'package:surat_jalan/services/letter_service.dart';

part 'letter_state.dart';

class LetterCubit extends Cubit<LetterState> {
  LetterCubit() : super(LetterInitial());

  void getAllLetter() async {
    emit(LetterLoading());
    try {
      List<LetterModel> letters = await LetterService().getAllLetter();
      emit(LetterLoaded(letters: letters));
    } catch (e) {
      emit(LetterError(message: e.toString()));
    }
  }
}

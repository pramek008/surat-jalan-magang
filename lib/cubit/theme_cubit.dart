import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/information_model.dart';
import '../services/information_service.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  void loadInformation() {
    emit(ThemeLoading());
    try {
      InformationService().getInformationFromStorage().then((informationModel) {
        emit(ThemeLoaded(informationModel: informationModel));
      });
    } catch (e) {
      emit(ThemeError(message: e.toString()));
    }
  }

  void loadImage() {
    emit(ThemeLoading());
    try {
      InformationService().getInformationFromStorage().then((image) {
        emit(ThemeImage(image: image.logoMain.toString()));
      });
    } catch (e) {
      emit(ThemeError(message: e.toString()));
    }
  }
}

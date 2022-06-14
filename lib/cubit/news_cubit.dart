import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:surat_jalan/services/news_service.dart';

import '../models/news_model.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  void getAllNews() async {
    emit(NewsLoading());
    try {
      final List<NewsModel> news = await NewsService().getAllNews();
      emit(NewsLoaded(news: news));
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }
}

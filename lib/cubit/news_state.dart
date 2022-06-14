part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsModel> news;

  NewsLoaded({required this.news});

  List<Object> get props => [news];
}

class NewsError extends NewsState {
  final String message;

  NewsError({required this.message});

  List<Object> get props => [message];
}

part of 'articles_cubit.dart';

@immutable
abstract class ArticlesState {}

class ArticlesInitial extends ArticlesState {}

class ArticlesLoading extends ArticlesState {}

class ArticlesSuccess extends ArticlesState {
  final List<ArticleModel> articles;

  ArticlesSuccess(this.articles);
}

class ArticlesError extends ArticlesState {
  final String error;

  ArticlesError(this.error);
}

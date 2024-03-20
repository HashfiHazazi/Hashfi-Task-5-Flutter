part of 'article_bloc.dart';

@immutable
sealed class ArticleState {}

final class ArticleInitial extends ArticleState {}

final class ArticleLoading extends ArticleInitial {}

final class ArticleLoaded extends ArticleInitial {
  final List<ArticleModel> articleList;

  ArticleLoaded({required this.articleList});
}

final class ArticleError extends ArticleInitial {}

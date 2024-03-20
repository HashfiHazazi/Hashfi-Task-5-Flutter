part of 'article_bloc.dart';

@immutable
sealed class ArticleEvent {}

final class LoadArticle extends ArticleEvent {}

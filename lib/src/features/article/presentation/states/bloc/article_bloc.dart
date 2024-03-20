import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:task5_application/src/features/article/application/services/article_service.dart';
import 'package:task5_application/src/features/article/domain/models/article_model.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleService articleService;
  ArticleBloc({required this.articleService}) : super(ArticleInitial()) {
    on<LoadArticle>(
      (event, emit) async {
        emit(ArticleLoading());
        await Future.delayed(const Duration(seconds: 3));
        try {
          final articleResult = await articleService.fetchArticle();
          emit(ArticleLoaded(articleList: articleResult));
        } catch (e) {
          emit(ArticleError());
        }
      },
    );
  }
}

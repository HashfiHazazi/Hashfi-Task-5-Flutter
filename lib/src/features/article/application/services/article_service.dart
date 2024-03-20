// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'package:dio/dio.dart';
import 'package:task5_application/src/features/article/data/repositories/article_repository.dart';
import 'package:task5_application/src/features/article/domain/models/article_model.dart';

class ArticleService implements ArticleRepository {
  static const String _articleUrl = 'https://demo.treblle.com/api/v1/articles';

  @override
  Future<List<ArticleModel>> fetchArticle() async {
    Dio _dio = Dio();
    Response response = await _dio.get(_articleUrl);
    final responseData = response.data['articles'];
    print('Article Reponse Data: $responseData');
    List<ArticleModel> listArticle = [];
    for (Map<String, dynamic> i in responseData) {
      listArticle.add(ArticleModel.fromJson(i));
    }
    return listArticle;
  }
}

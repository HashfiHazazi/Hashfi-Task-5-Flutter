import 'package:task5_application/src/features/article/domain/models/article_model.dart';

abstract class ArticleRepository {
  Future<List<ArticleModel>> fetchArticle();
}

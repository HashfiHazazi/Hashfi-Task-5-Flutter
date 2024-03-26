import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task5_application/src/exceptions/error/not_found_page.dart';
import 'package:task5_application/src/features/article/application/services/article_service.dart';
import 'package:task5_application/src/features/article/presentation/states/bloc/article_bloc.dart';
import 'package:task5_application/src/features/article/presentation/widgets/article_page.dart';
import 'package:task5_application/src/features/article/presentation/widgets/shimmer_article_annimation.dart';
import 'package:task5_application/src/features/login/presentation/widgets/login_page.dart';
import 'package:task5_application/src/features/profile/presentation/widgets/profile_page.dart';
import 'package:task5_application/src/routers/route_names.dart';

class RoutePages {
  //Bloc Dependency injection
  final ArticleBloc _articleBloc = ArticleBloc(articleService: ArticleService())
    ..add(LoadArticle());

  Route onRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );

      case RouteNames.article:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _articleBloc..add(LoadArticle()),
            child: const ArticlePage(),
          ),
        );

      case RouteNames.profile:
        return MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        );

      case RouteNames.shimmer:
        return MaterialPageRoute(
          builder: (context) => const ShimmerArticleAnnimation(),
        );

      default:
        return MaterialPageRoute(builder: (context) => const NotFoundPage());
    }
  }
}

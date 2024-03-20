import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:task5_application/src/exceptions/error/not_found_page.dart';
import 'package:task5_application/src/features/article/application/services/article_service.dart';
import 'package:task5_application/src/features/article/presentation/states/bloc/article_bloc.dart';
import 'package:task5_application/src/features/article/presentation/widgets/shimmer_article_annimation.dart';
import 'package:task5_application/src/features/login/presentation/states/login_local_storage.dart';
import 'package:task5_application/src/routers/route_names.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ArticleBloc articleBloc =
        ArticleBloc(articleService: ArticleService())..add(LoadArticle());

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ArticleBloc, ArticleState>(
          bloc: articleBloc,
          builder: (context, state) {
            if (state is ArticleLoading) {
              return const ShimmerArticleAnnimation();
            } else if (state is ArticleLoaded) {
              final articleData = state.articleList;
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 24),
                    child: FutureBuilder(
                      future: LoginLocalStorage.getUserName(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Row(
                            children: [
                              Text(
                                'Welcome, null',
                                style: Theme.of(context).textTheme.titleLarge,
                              )
                            ],
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Welcome, ',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    '${snapshot.data}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteNames.profile);
                                },
                                child: Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.10),
                                      shape: BoxShape.circle),
                                  child: LottieBuilder.asset(
                                      'assets/lotties/lottie_profile.json'),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final articleResult = articleData[index];
                        return UnconstrainedBox(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            width: 210,
                            height: 190,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.primary),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  articleResult.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  articleResult.content,
                                  maxLines: 7,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: articleData.length,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final articleResult = articleData[index];
                          DateTime date =
                              DateTime.parse(articleResult.created!.date);
                          String formattedDate =
                              DateFormat('d MMMM yyyy, HH:mm:ss').format(date);
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            height: 210,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          articleResult.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        articleResult.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  articleResult.content,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    formattedDate,
                                    maxLines: 1,
                                    textAlign: TextAlign.right,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: articleData.length,
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ArticleError) {
              return const Center(
                child: Text('Article Error'),
              );
            } else {
              return const NotFoundPage();
            }
          },
        ),
      ),
    );
  }
}

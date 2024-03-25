import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:task5_application/src/exceptions/error/not_found_page.dart';
import 'package:task5_application/src/features/article/application/services/article_service.dart';
import 'package:task5_application/src/features/article/presentation/states/bloc/article_bloc.dart';
import 'package:task5_application/src/features/article/presentation/widgets/shimmer_article_annimation.dart';
import 'package:task5_application/src/modules/local_storage/login_local_storage.dart';
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
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: LoginLocalStorage.getUserName(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Row(
                          children: [
                            Text(
                              'Welcome, ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'null',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ],
                        );
                      } else {
                        return Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  const Text(
                                    'Welcome, ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    '${snapshot.data}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
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
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  SizedBox(
                    height: 190,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final articleResult = articleData[index];
                        return UnconstrainedBox(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            width: 210,
                            height: 190,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.primary),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  articleResult.title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  articleResult.content,
                                  maxLines: 6,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                  const SizedBox(
                    height: 19,
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final articleResult = articleData[index];
                        DateTime date =
                            DateTime.parse(articleResult.created!.date);
                        String formattedDate =
                            DateFormat('d MMMM yyyy, HH:mm:ss').format(date);
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          height: 200,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        articleResult.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      articleResult.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: Text(
                                  articleResult.content,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  formattedDate,
                                  maxLines: 1,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: articleData.length,
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

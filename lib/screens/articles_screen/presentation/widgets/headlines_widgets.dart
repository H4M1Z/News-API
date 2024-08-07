import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api/screens/articles_screen/presentation/controller/news_notifier.dart';
import 'package:news_api/screens/articles_screen/presentation/widgets/headline_article_btns.dart';
import 'package:news_api/screens/articles_screen/presentation/widgets/headline_article_view.dart';

import '../../domain/models/article.dart';

//...LOADED ARTICLES WIDGET TO SHOW IN CASE OF SUCCESS
class ArticlesLoadedWidget extends ConsumerStatefulWidget {
  const ArticlesLoadedWidget(
      {super.key, required this.articles, required this.hasMoreData});
  final List<Article> articles;
  final bool hasMoreData;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArticlesState();
}

class _ArticlesState extends ConsumerState<ArticlesLoadedWidget> {
  //...CONSTANT VALUES
  static const _paddingFromBottom = 0.02;
  static const _loadingStrokeWidth = 2.0;

  late final NewsNotifier newsNotifier;
  @override
  void initState() {
    newsNotifier = ref.read(newsNotifierProvider.notifier);
    //.....THIS FUNCTION WILL BE TRIGGERED EVERY TIME WHEN WE SCROLL BUT WE WILL ONLY GET THE ARTICLES WHEN THE CONTROLLER WILL REACH ITS MAXIMUM POSITION.
    newsNotifier.controller.addListener(newsNotifier.getHeadLineArticles);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size(:height) = MediaQuery.sizeOf(context);
    return Center(
      child: ListView.custom(
        controller: newsNotifier.controller,
        childrenDelegate: SliverChildBuilderDelegate(
          childCount: widget.articles.length + 1,
          (context, index) {
            if (index < widget.articles.length) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: height * _paddingFromBottom,
                ),
                child: HeadLineArticleView(
                  article: widget.articles[index],
                ),
              );
            } else {
              if (widget.hasMoreData) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: _loadingStrokeWidth,
                  ),
                );
              } else {
                return const SizedBox();
              }
            }
          },
        ),
      ),
    );
  }
}

//...ERROR WIDGET TO SHOW IN CASE OR ERROR
class ArticlesErrorWidget extends StatelessWidget {
  const ArticlesErrorWidget({super.key});
  //...IMAGES PATHS
  static const _errorImage = 'assets/images/error_page.jpg';
  //...PADDING VALUES
  static const _paddingFromTop = 0.6;
  static const _paddingFromLeft = 0.1;
  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return SizedBox.expand(
      child: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              _errorImage,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: height * _paddingFromTop,
            left: width * _paddingFromLeft,
            child: const RetryButton(),
          )
        ],
      ),
    );
  }
}

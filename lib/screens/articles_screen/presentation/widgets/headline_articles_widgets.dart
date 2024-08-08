import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_api/core/utils/colors.dart';
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
  static const _loadingSize = 0.08;
  //...CONTROLLERS
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    //...DISPOSE OFF THE CONTROLLER TO PREVENT ANY MEMORY LEAKS
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size(:height) = MediaQuery.sizeOf(context);
    return Center(
      child: ListView.custom(
        controller: _scrollController,
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
              //...SHOW LOADING WHEN THE INDEX IS GREATER THEN THE ARTICLES LENGTH
            } else {
              if (widget.hasMoreData) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.darkPurple,
                    size: height * _loadingSize,
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

  //.....THIS FUNCTION WILL BE TRIGGERED EVERY TIME WHEN WE SCROLL BUT WE WILL ONLY GET THE ARTICLES WHEN THE CONTROLLER WILL REACH ITS MAXIMUM POSITION.
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(newsNotifierProvider.notifier).getHeadLineArticles();
    }
  }
}

//...ERROR WIDGET TO SHOW IN CASE OR ERROR
class ArticlesErrorWidget extends StatelessWidget {
  const ArticlesErrorWidget({super.key});
  //...IMAGE PATH
  static const _errorImage = 'assets/images/error_page.jpg';
  //...PADDING VALUES
  static const _paddingFromTop = 0.59;
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

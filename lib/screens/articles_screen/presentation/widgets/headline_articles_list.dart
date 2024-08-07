import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api/screens/articles_screen/presentation/controller/news_notifier.dart';
import 'package:news_api/screens/articles_screen/presentation/controller/news_states.dart';
import 'package:news_api/screens/articles_screen/presentation/widgets/headlines_widgets.dart';

class HeadLineArticlesList extends ConsumerWidget {
  const HeadLineArticlesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var newsNotifier = ref.read(newsNotifierProvider.notifier);
    var state = ref.watch(newsNotifierProvider);
    if (state is NewsInitialState || state is NewsLoadingState) {
      return ArticlesLoadedWidget(
          articles: newsNotifier.articles, hasMoreData: state.hasMoreData!);
    } else if (state is HeadlineArticlesLoadedState) {
      return ArticlesLoadedWidget(
          articles: state.articles, hasMoreData: state.hasMoreData!);
    } else {
      return const ArticlesErrorWidget();
    }
  }
}

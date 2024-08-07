import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api/screens/articles_screen/presentation/controller/news_notifier.dart';
import 'package:news_api/screens/articles_screen/presentation/controller/news_states.dart';

class HeadLineArticlesList extends ConsumerWidget {
  const HeadLineArticlesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(newsNotifierProvider);
    if (state is NewsInitialState || state is NewsLoadingState) {
      return const SizedBox();
    } else if (state is HeadlineArticlesLoadedState) {
      return const SizedBox();
    } else {
      return const SizedBox();
    }
  }
}

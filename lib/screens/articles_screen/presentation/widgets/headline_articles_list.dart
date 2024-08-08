import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api/core/utils/common_functions.dart';
import 'package:news_api/screens/articles_screen/presentation/controller/news_notifier.dart';
import 'package:news_api/screens/articles_screen/presentation/controller/news_states.dart';
import 'package:news_api/screens/articles_screen/presentation/widgets/headlines_widgets.dart';

class HeadLineArticlesList extends ConsumerWidget {
  const HeadLineArticlesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(newsNotifierProvider);
    if (state is NewsInitialState) {
      return const SizedBox();
    } else if (state is NewsLoadingState) {
      //...WE WILL DISPLAY THE ALREADY PRESENT DATA TO THE USER IN CASE OF LAODING
      return ArticlesLoadedWidget(
          articles: ref.read(newsNotifierProvider.notifier).articles,
          hasMoreData: state.hasMoreData!);
    } else if (state is HeadlineArticlesLoadedState) {
      return ArticlesLoadedWidget(
          articles: state.articles, hasMoreData: state.hasMoreData!);
    } else {
      //...WE WILL SHOW A SNACKBAR CONTAINING THE ERROR MESSAGE
      SchedulerBinding.instance.addPostFrameCallback(
        (_) => showSnackBar(
          context,
          (state as NewsErrorState).errorMessage,
        ),
      );
      return const ArticlesErrorWidget();
    }
  }
}

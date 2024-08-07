import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api/screens/articles_screen/presentation/controller/news_notifier.dart';
import 'package:news_api/screens/articles_screen/presentation/widgets/headline_articles_list.dart';

class HeadLineArticles extends ConsumerWidget {
  const HeadLineArticles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //...AS SOON AS THE SCREEN IS BUILT WE WILL FETCH THE HEADLINE ARTCILES
    SchedulerBinding.instance.addPostFrameCallback(
        (_) => ref.read(newsNotifierProvider.notifier).getHeadLineArticles());
    return const Scaffold(
      body: HeadLineArticlesList(),
    );
  }
}

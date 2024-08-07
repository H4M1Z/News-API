import 'package:flutter/material.dart';
import 'package:news_api/screens/articles_screen/domain/models/article.dart';

@immutable
abstract class NewsStates {
  final bool? hasMoreData;
  const NewsStates({this.hasMoreData});
}

@immutable
final class NewsInitialState extends NewsStates {
  const NewsInitialState({super.hasMoreData});
}

@immutable
final class NewsLoadingState extends NewsStates {
  const NewsLoadingState({super.hasMoreData});
}

@immutable
final class HeadlineArticlesLoadedState extends NewsStates {
  final List<Article> articles;
  const HeadlineArticlesLoadedState(
      {required this.articles, super.hasMoreData});
}

@immutable
final class NewsErrorState extends NewsStates {}

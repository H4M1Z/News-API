import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api/screens/articles_screen/data/respositories/news_repo_impl.dart';
import 'package:news_api/screens/articles_screen/domain/models/article.dart';
import 'package:news_api/screens/articles_screen/presentation/controller/news_states.dart';

//...NEWS NOTIFIER PROVIDER
final newsNotifierProvider =
    NotifierProvider<NewsNotifier, NewsStates>(NewsNotifier.new);

class NewsNotifier extends Notifier<NewsStates> {
  @override
  NewsStates build() {
    return const NewsInitialState(hasMoreData: false);
  }

  //...ERROR MESSAGE
  static const _errorMessage = 'Check Your Internet Connection!';
  //...SOURCE
  static const _source = 'bbc-news';
  //...TO KEEP TRACK OF THE CURRENT PAGE
  var _page = 1;
  //...TOTAL ITEMS TO SHOW ON THE SCREEN
  static const _pageSize = 4;
  //...TO KEEP TRACK IF THERE IS MORE DATA AVAILABLE AT HE SERVER OR NOT
  var _hasMoreData = true;
  //... A LIST OF HEADLINES TO KEEP THE PREVIOUS DATA STORED AND THE INCOMING DATA FROM THE SERVER
  var articles = <Article>[];

  //....THIS FUNCTION WILL GET THE HEADLINES FROM THE SERVER
  void getHeadLineArticles() async {
    try {
      //...IF THERE IS MORE DATA AVAILABLE ONLY THEN WE WILL GET IT.
      if (_hasMoreData) {
        state = NewsLoadingState(hasMoreData: _hasMoreData);
        var response = await ref
            .read(newsRepositoryProvider)
            .getHeadLineArticles(
                source: _source, page: _page, pageSize: _pageSize);
        articles.addAll(response.articles);
        _hasMoreData = (_page < response.totalResults ~/ _pageSize);
        _page++;
        state = HeadlineArticlesLoadedState(
            articles: articles, hasMoreData: _hasMoreData);
      }
    } catch (e) {
      //...IF SOMETHING GOES WRONG RETURN ERROR STATE
      log(e.toString());
      state = const NewsErrorState(errorMessage: _errorMessage);
    }
  }
}

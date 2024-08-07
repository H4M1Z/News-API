import 'dart:developer';

import 'package:flutter/material.dart';
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
    //...DISPOSE OFF THE CONTROLLER AFTER USE TO PREVENT MEMORY LEAKS
    ref.onDispose(controller.dispose);
    return const NewsInitialState(hasMoreData: false);
  }

  //...SOURCE
  static const _source = 'bbc-news';
  //...SCROLL CONTROLLER FOR PAGINATION
  final ScrollController controller = ScrollController();
  //...TO KEEP TRACK OF THE CURRENT PAGE
  var _page = 1;
  //...TOTAL ITEMS TO SHOW ON THE SCREEN
  static const _pageSize = 4;
  //...TO KEEP TRACK IF THERE IS MORE DATA AVAILABLE AT HE SERVER OR NOT
  var _hasMoreData = true;
  //...IF A USER RTRIES TO GET THE DATA AFTER ERROR THERE WILL BE NO SCROLL CONTROLLER SO WE WILL GET THE DATA ON THE BASIS OF THIS BOOLEAN
  var _isRetryPressed = false;
  //... A LIST OF HEADLINES TO KEEP THE PREVIOUS DATA STORED AND THE INCOMING DATA FROM THE SERVER
  var articles = <Article>[];

  //....THIS FUNCTION WILL GET THE HEADLINES FROM THE SERVER
  void getHeadLineArticles({bool? retryPressed}) async {
    try {
      //...IF THERE IS MORE DATA AVAILABLE ONLY THEN WE WILL GET IT.
      if (_hasMoreData) {
        //...IF A USER PRESSES RETRY AFTER A FAILED REQUEST WE WILL GET THE DATA FROM THE SERVER AGAIN ON THE BASIS OF THIS BOOL BECAUSE AT THAT PARTICULAR PAGE THERE WILL BE NO SCROLL CONTROLLER ATTACHED TO ANY SCROLL VIEWS
        _isRetryPressed = retryPressed ?? false;
        //...OTHER WISE IF THE SCROLL CONTROLLER REACHES IT'S MAX EXTENT THAN WE WILL FETCH THE NEXT DATA AND STORE IT IN THE ARTICLES LIST AND CHECK IF THERE IS MORE DATA AVAILABLE OR NOT.
        if (_isRetryPressed ||
            controller.position.pixels == controller.position.maxScrollExtent) {
          state = NewsLoadingState(hasMoreData: _hasMoreData);
          var response = await ref
              .read(newsRepositoryProvider)
              .getHeadLineArticles(
                  source: _source, page: _page, pageSize: _pageSize);
          articles.addAll(response.articles);
          _hasMoreData = (_page < response.totalResults ~/ _pageSize);
          _page++;
          _isRetryPressed = false;
          state = HeadlineArticlesLoadedState(
              articles: articles, hasMoreData: _hasMoreData);
        }
      }
    } catch (e) {
      //...IF SOMETHING GOES WRONG RETURN ERROR STATE
      log(e.toString());
      state = NewsErrorState();
    }
  }
}

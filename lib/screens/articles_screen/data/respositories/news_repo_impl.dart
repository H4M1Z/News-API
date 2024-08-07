import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api/screens/articles_screen/domain/models/headlines_response.dart';

import '../../domain/repositories/news_repo.dart';
import '../data_sources/remote/news_service.dart';

//...NEWS REPO PROVIDER
final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepository(headLinesClient: HeadLinesService());
});

//...REPO THROUGH WHICH WE WILL GET THE DATA AND MAKE REQUEST.BASICALLY THIS REPO WILL BE RESPONSIBLE TO MAKE ALL THE REQUESTS RELATED TO NEWS SERVER
class NewsRepository implements AbstractNewsRepository {
  NewsRepository({required this.headLinesClient});
  final HeadLinesService headLinesClient;
  //....THIS FUNC IS RESPONSIBLE FOR CALLING THE HEADLINES FUNCTION DEFINED IN THE HEADLINES SERVICE
  @override
  Future<HeadLinesResponse> getHeadLineArticles(
          {required String source,
          required int page,
          required int pageSize}) async =>
      await headLinesClient.getHeadLineArticles(
          sources: source, page: page, pageSize: pageSize);
}

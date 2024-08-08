import '../models/headlines_response.dart';

//....THIS CLASS WILL CONTAIN ALL THE ABSTRACT FUNCTIONS REALTED TO NEWS SERVER FOR BETTER AND MAINTAINABLE CODE AND AS THE API KEY WILL REMAIN SAME WE WILL DEFINE IT HERE
abstract class AbstractNewsRepository {
  //......TO GET HEADLINE ARTICLES
  Future<HeadLinesResponse> getHeadLineArticles(
      {required String source, required int page, required int pageSize});
}

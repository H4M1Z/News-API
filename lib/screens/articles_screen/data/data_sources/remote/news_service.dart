import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:news_api/screens/articles_screen/domain/models/headlines_response.dart';

//...EXTENSION TO CHECK WETHER THE REQUEST IS SUCCES OR NOT
extension on Response {
  bool get isSuccessful => statusCode == 200;
}

abstract class NewsApiService {
  //...BASE URL
  String get baseUrl => 'https://newsapi.org/v2';
  //...EVERY CHILD CLASS WILL PROVIDE IT'S OWN API URL
  String get apiUrl;
  String get apiKey => 'b75331e9366941d0a9b490e4e0e844e8';

  //...REQUEST TO GET DATA FROM SERVER
  fetch({required String endPoint}) async {
    try {
      final url = '$baseUrl$endPoint';
      var response = await get(
        Uri.parse(
          url,
        ),
      );
      return response.isSuccessful
          ? jsonDecode(
              response.body,
            )
          : null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

///.....HEADLINES SERVICE
class HeadLinesService extends NewsApiService {
  @override
  String get apiUrl => '/top-headlines';

  //...FUNC TO GET HEADLINE ARTCILES
  ///...... IN THIS FUNC WE WILL TAKE THE SOURCE FROM WHICH WE WANT TO GET THE NEWS FROM AND THE PAGE AND PAGE SIZE SO THAT WE CAN GET THE DATA IN SMALL CHUNKS AND NOT ALL OF IT AT ONCE.
  Future<HeadLinesResponse> getHeadLineArticles(
      {required String sources,
      required int page,
      required int pageSize}) async {
    final String endPoint =
        '$apiUrl?sources=$sources&apiKey=$apiKey&page=$page&pageSize=$pageSize';
    var response = await fetch(endPoint: endPoint);
    return HeadLinesResponse.fromMap(response);
  }
}

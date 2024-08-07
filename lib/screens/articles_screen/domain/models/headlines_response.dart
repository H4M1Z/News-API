// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:news_api/screens/articles_screen/domain/models/article.dart';

class HeadLinesResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;
  HeadLinesResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  HeadLinesResponse copyWith({
    String? status,
    int? totalResults,
    List<Article>? articles,
  }) {
    return HeadLinesResponse(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      articles: articles ?? this.articles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'totalResults': totalResults,
      'articles': articles.map((x) => x.toMap()).toList(),
    };
  }

  factory HeadLinesResponse.fromMap(Map<String, dynamic> map) {
    return HeadLinesResponse(
      status: map['status'] as String,
      totalResults: map['totalResults'] as int,
      articles: List<Article>.from(
        (map['articles'] as List).map<Article>(
          (x) => Article.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory HeadLinesResponse.fromJson(String source) =>
      HeadLinesResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ApiResponse(status: $status, totalResults: $totalResults, articles: $articles)';

  @override
  bool operator ==(covariant HeadLinesResponse other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.totalResults == totalResults &&
        listEquals(other.articles, articles);
  }

  @override
  int get hashCode =>
      status.hashCode ^ totalResults.hashCode ^ articles.hashCode;
}

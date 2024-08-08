import 'package:flutter/material.dart';
import 'package:news_api/screens/articles_screen/presentation/widgets/headline_article_btns.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/styles.dart';
import '../../domain/models/article.dart';

class ArticleDetails extends StatelessWidget {
  const ArticleDetails({super.key, required this.article});
  final Article article;
  //...CONSTANT VALUES
  static const _textMaxLines = 3;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: Flexes.flexTen,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: FittedBox(
              child: Text(
                article.author,
                style: AppTextStyles.newsAurthorStyle,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Center(
            child: Text(
              article.title,
              maxLines: 2,
              style: AppTextStyles.newsTitleStyle,
            ),
          ),
        ),
        Expanded(
          flex: Flexes.flexEighteen,
          child: Text(
            article.description,
            maxLines: _textMaxLines,
            style: AppTextStyles.newsTitleStyle.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        const Expanded(
          flex: Flexes.flexTen,
          child: MoreButton(),
        ),
        const Spacer(
          flex: Flexes.flexOne,
        ),
      ],
    );
  }
}

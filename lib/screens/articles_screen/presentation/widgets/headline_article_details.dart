import 'package:flutter/material.dart';
import 'package:news_api/screens/articles_screen/presentation/widgets/headline_article_btn.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/styles.dart';
import '../../domain/models/article.dart';

class ArticleDetails extends StatelessWidget {
  const ArticleDetails({super.key, required this.article});
  final Article article;
  //...PADDING VALUES
  static const _textPaddingFromTop = 0.03;
  @override
  Widget build(BuildContext context) {
    final Size(:height) = MediaQuery.sizeOf(context);
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
          flex: Flexes.flexTen,
          child: Center(
            child: Text(
              article.title,
              style: AppTextStyles.newsTitleStyle,
            ),
          ),
        ),
        Expanded(
          flex: Flexes.flexEighteen,
          child: Padding(
            padding: EdgeInsets.only(
              top: height * _textPaddingFromTop,
            ),
            child: Text(
              article.description,
              style: AppTextStyles.newsTitleStyle.copyWith(
                fontWeight: FontWeight.normal,
              ),
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

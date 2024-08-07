import 'package:flutter/material.dart';
import 'package:news_api/core/utils/constants.dart';
import 'package:news_api/screens/articles_screen/presentation/widgets/headline_article_details.dart';
import 'package:news_api/screens/articles_screen/presentation/widgets/headline_article_image.dart';

import '../../../../core/utils/colors.dart';
import '../../domain/models/article.dart';

class HeadLineArticleView extends StatelessWidget {
  const HeadLineArticleView({super.key, required this.article});
  final Article article;
  //...SIZES
  static const containerWidth = 0.9;
  static const containerHeight = 0.29;
  //...DECORATION
  static const _borderRadius = 30.0;
  static const _blurRadius = 5.0;
  static const _spreadRadius = 1.0;
  static const _shadow = Offset(0, 2);
  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Center(
      child: Container(
        width: width * containerWidth,
        height: height * containerHeight,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          boxShadow: const [
            BoxShadow(
              color: AppColors.dimBlackColor,
              blurRadius: _blurRadius,
              spreadRadius: _spreadRadius,
              offset: _shadow,
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: Flexes.flexTen,
              child: ArticleImage(
                image: article.urlToImage,
              ),
            ),
            Expanded(
              flex: Flexes.flexTen,
              child: ArticleDetails(
                article: article,
              ),
            ),
            const Spacer(
              flex: Flexes.flexOne,
            )
          ],
        ),
      ),
    );
  }
}

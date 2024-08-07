import 'package:flutter/material.dart';
import 'package:news_api/core/utils/colors.dart';

class ArticleImage extends StatelessWidget {
  const ArticleImage({super.key, required this.image});
  final String image;
  //...SIZES
  static const _containerWidthAndHeight = 0.8;
  //...DECORATION
  static const _borderRadius = 20.0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final BoxConstraints(:maxWidth, :maxHeight) = constraints;
          return Container(
            width: maxWidth * _containerWidthAndHeight,
            height: maxHeight * _containerWidthAndHeight,
            decoration: BoxDecoration(
              color: AppColors.greyishPink,
              borderRadius: BorderRadius.circular(
                _borderRadius,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  image,
                ),
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }
}

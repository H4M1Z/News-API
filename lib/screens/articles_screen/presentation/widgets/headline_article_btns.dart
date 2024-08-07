import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api/core/utils/colors.dart';
import 'package:news_api/core/utils/styles.dart';
import 'package:news_api/screens/articles_screen/presentation/controller/news_notifier.dart';

//...MORE BTN TO SHOW ON ARTICLE CARD AND TO NAVIGATE THE USER TO SEE FULL NEWS
class MoreButton extends StatelessWidget {
  const MoreButton({super.key});
  //...SIZES
  static const _containerWidth = 0.4;
  static const _containerHeight = 0.7;
  //...PADDING VALUES
  static const _paddingFromRight = 20.0;
  static const _paddingFromBottom = 5.0;
  //...DECORATION
  static const _borderRadius = 30.0;
  //...TEXTS
  static const _btnText = 'More';
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final BoxConstraints(:maxWidth, :maxHeight) = constraints;
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(
                right: _paddingFromRight, bottom: _paddingFromBottom),
            child: Container(
              width: maxWidth * _containerWidth,
              height: maxHeight * _containerHeight,
              decoration: BoxDecoration(
                color: AppColors.darkPurple,
                borderRadius: BorderRadius.circular(
                  _borderRadius,
                ),
              ),
              child: const Center(
                child: Text(
                  _btnText,
                  style: AppTextStyles.newsBtnStyle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

//....RETRY BUTTON TO FETCH DATA AGAIN IN CASE OF SOME ERROR
class RetryButton extends ConsumerWidget {
  const RetryButton({super.key});
  //...SIZES
  static const _containerWidth = 0.2;
  static const _containerHeight = 0.05;
  //...DECORATION
  static const _borderRadius = 20.0;
  //...TEXTS
  static const _btnText = 'RETRY';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => ref
          .read(newsNotifierProvider.notifier)
          .getHeadLineArticles(retryPressed: true),
      child: Container(
        width: width * _containerWidth,
        height: height * _containerHeight,
        decoration: BoxDecoration(
          color: AppColors.lightGreen,
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: const Center(
          child: Text(
            _btnText,
            style: AppTextStyles.newsBtnStyle,
          ),
        ),
      ),
    );
  }
}

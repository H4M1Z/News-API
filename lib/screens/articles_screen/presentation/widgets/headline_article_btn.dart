import 'package:flutter/material.dart';
import 'package:news_api/core/utils/colors.dart';
import 'package:news_api/core/utils/styles.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({super.key});
  //...SIZES
  static const _containerWidth = 0.4;
  static const _containerHeight = 0.8;
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

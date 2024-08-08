import 'package:flutter/material.dart';
import 'package:news_api/core/utils/colors.dart';

class AppTextStyles {
  static const newsAurthorStyle = TextStyle(
    color: AppColors.darkPurple,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    fontFamily: 'Google Fonts',
  );
  static const newsTitleStyle = TextStyle(
    color: AppColors.lightGrey,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );
  static const newsBtnStyle = TextStyle(
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w600,
    fontSize: 10,
  );
}

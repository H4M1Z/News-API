import 'package:flutter/material.dart';
import 'package:news_api/core/utils/colors.dart';

//...CUSTOM SNACKBAR
showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(
            color: AppColors.blackColor,
          ),
        ),
      ),
      duration: const Duration(
        seconds: 1,
      ),
      backgroundColor: AppColors.darkYellow,
      behavior: SnackBarBehavior.floating,
      width: 300,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(
          30,
        ),
      ),
    ),
  );
}

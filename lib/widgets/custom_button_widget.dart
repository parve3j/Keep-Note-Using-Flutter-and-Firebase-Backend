import 'package:flutter/material.dart';

import '../../const/app_colors.dart';

Widget customButton(String title, onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(title),
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.appColor,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 16,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30)
    ),
  );
}
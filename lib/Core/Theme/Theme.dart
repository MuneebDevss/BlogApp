import 'package:flutter/material.dart';
import 'package:blog_app_vs/Core/Theme/Palatte.dart';
class AppTheme {
  static OutlineInputBorder _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      width: 3,
      color: color,
    ),
  );

  static final darkBackground = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient1),
      errorBorder: _border(AppPallete.errorColor),
    ),
  );
}
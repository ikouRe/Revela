import 'package:flutter/material.dart';
import 'package:revela/core/theme/revela_colors.dart';

ThemeData revelaTheme(){
  return ThemeData(
      colorScheme:ColorScheme.fromSeed(
      seedColor:RevelaColors.accent,
        primary: RevelaColors.accent,
        surface:RevelaColors.perle,
        onSurface:RevelaColors.encre,
  ),

  scaffoldBackgroundColor: RevelaColors.perle,

    fontFamily: 'Figtree',

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'ZenMaruGothic',
        fontSize: 42,
        fontWeight: FontWeight.w700,
        color: RevelaColors.encre,
      ),
      titleLarge: TextStyle(
        fontFamily: 'ZenMaruGothic',
        fontSize: 21,
        fontWeight: FontWeight.w700,
        color: RevelaColors.encre,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: RevelaColors.encre,
      ),
    ),
  );

}

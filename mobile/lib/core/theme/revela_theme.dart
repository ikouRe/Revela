import 'package:flutter/material.dart';

import 'revela_colors.dart';

/// Instrument Serif for editorial titles, Manrope for everything else.
abstract final class RevelaTheme {
  static const display = 'InstrumentSerif';
  static const ui = 'Manrope';

  static ThemeData light() => _build(
    const ColorScheme(
      brightness: Brightness.light,
      primary: RevelaColors.uv,
      onPrimary: Colors.white,
      secondary: RevelaColors.peche,
      onSecondary: RevelaColors.nuit,
      error: RevelaColors.deconseille,
      onError: Colors.white,
      surface: RevelaColors.nacre,
      onSurface: RevelaColors.nuit,
    ),
  );

  static ThemeData dark() => _build(
    const ColorScheme(
      brightness: Brightness.dark,
      primary: RevelaColors.uv,
      onPrimary: Colors.white,
      secondary: RevelaColors.peche,
      onSecondary: RevelaColors.nuit,
      error: RevelaColors.deconseille,
      onError: Colors.white,
      surface: RevelaColors.nuit,
      onSurface: RevelaColors.nacre,
    ),
  );

  static ThemeData _build(ColorScheme scheme) {
    final base = ThemeData(useMaterial3: true, colorScheme: scheme, fontFamily: ui);
    TextStyle serif(double size, double height) =>
        TextStyle(fontFamily: display, fontSize: size, height: height, fontWeight: FontWeight.w400);
    return base.copyWith(
      scaffoldBackgroundColor: scheme.surface,
      textTheme: base.textTheme
          .copyWith(
            displayLarge: serif(48, 1.05),
            displayMedium: serif(40, 1.1),
            headlineLarge: serif(32, 1.15),
            headlineMedium: serif(28, 1.2),
            titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 1.3),
            titleMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, height: 1.35),
            bodyLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5),
            bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.5),
            labelLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.2),
            labelSmall: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.2),
          )
          .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface),
    );
  }
}

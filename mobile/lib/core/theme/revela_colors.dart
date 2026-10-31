import 'package:flutter/painting.dart';

/// Revela palette — source of truth: reveala/brand/build.py and GUIDE.md.
abstract final class RevelaColors {
  static const uv = Color(0xFF6447FF);
  static const nuit = Color(0xFF16122B);
  static const nacre = Color(0xFFF7F4EF);
  static const peche = Color(0xFFFFB496);

  // RG-37 verdict colours, each >= 3:1 against both nacre and nuit.
  static const compatible = Color(0xFF178A6A);
  static const prudence = Color(0xFFB86F00);
  static const deconseille = Color(0xFFD2385A);
  static const inconnu = Color(0xFF86828F);
}

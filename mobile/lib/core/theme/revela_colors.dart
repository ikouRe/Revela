import 'package:flutter/painting.dart';

/// Couleurs de Perle et verre, reprises de Revela/DESIGN.md.
abstract final class RevelaColors {
  // Marque
  static const accent = Color(0xFFB92B52);
  static const accentFort = Color(0xFF961F41);
  static const degradeDebut = Color(0xFFFFB296);
  static const degradeMilieu = Color(0xFFD64A72);
  static const peche = Color(0xFFFFC4AB);
  static const rose = Color(0xFFF8B3C8);
  static const lilas = Color(0xFFDCD0F4);

  // Fonds et surfaces
  static const perle = Color(0xFFFBF1F0);
  static const blanc = Color(0xFFFFFBFA);
  static const blancPur = Color(0xFFFFFFFF);
  static const creux = Color(0xFFFBEEEE);
  static const trait = Color(0xFFF2E3E4);
  static const poignee = Color(0xFFE2CFD6);
  static const desactive = Color(0xFFD9C6CF);

  // Texte
  static const encre = Color(0xFF3A1A2B);
  static const encre2 = Color(0xFF6B4557);

  // Nuit (splash, révélation)
  static const nuit = Color(0xFF26101D);
  static const nuitLueur = Color(0xFF6D3A52);
  static const nuitTexte = Color(0xFFF2DFE6);

  // Verdicts (RG-37 : toujours avec une icône et un texte, jamais la couleur seule)
  static const bon = Color(0xFF1C6E53);
  static const bonFond = Color(0xFFDFF2E9);
  static const prudence = Color(0xFF8C4C00);
  static const prudenceFond = Color(0xFFFDECD2);
  static const prudenceTexte = Color(0xFF5C3200);
  static const mauvais = Color(0xFFA8261F);
  static const mauvaisFond = Color(0xFFFCE1DE);
  static const inconnu = Color(0xFF5E4D57);
  static const inconnuFond = Color(0xFFEEE6EA);

  /// Dégradé de la marque (icône, boutons forts).
  static const degrade = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [degradeDebut, degradeMilieu, accentFort],
    stops: [0, .55, 1],
  );
}

import 'package:flutter/material.dart';

import '../theme/revela_colors.dart';

/// RG-32 / RG-33 verdicts. RG-37: always shown as colour + icon + text.
enum Verdict {
  compatible(RevelaColors.compatible, Icons.check_rounded, 'Compatible avec ta peau', 44),
  prudence(RevelaColors.prudence, Icons.priority_high_rounded, 'Prudence', 72),
  deconseille(RevelaColors.deconseille, Icons.close_rounded, 'Déconseillé', 94),
  inconnu(RevelaColors.inconnu, Icons.question_mark_rounded, 'Analyse insuffisante', 140);

  const Verdict(this.color, this.icon, this.label, this.distance);

  final Color color;
  final IconData icon;
  final String label;

  /// Distance between ring centres (256 grid): the closer, the larger the revealed lens.
  /// INCONNU keeps the rings apart — nothing revealed.
  final double distance;
}

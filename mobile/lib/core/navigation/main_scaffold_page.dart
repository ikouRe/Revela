import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../theme/revela_colors.dart';

class MainScaffoldPage extends StatefulWidget {
  const MainScaffoldPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainScaffoldPage> createState() => _MainScaffoldPageState();
}

class _MainScaffoldPageState extends State<MainScaffoldPage>
    with SingleTickerProviderStateMixin {
  ui.FragmentProgram? _programme;

  @override
  void initState() {
    super.initState();
    _charger();
    _ticker.start();
  }

  Future<void> _charger() async {
    final programme = await ui.FragmentProgram.fromAsset('shaders/bulle.frag');
    if (!mounted) return;
    setState(() => _programme = programme);
  }

  final _temps = ValueNotifier<double>(0);
  late final _position = ValueNotifier<double>(
    widget.navigationShell.currentIndex.toDouble(),
  );
  double _vitesse = 0;
  Duration _avant = Duration.zero;
  late final Ticker _ticker = createTicker((ecoule) {
    _temps.value = ecoule.inMicroseconds / 1e6;

    var reste = (ecoule - _avant).inMicroseconds / 1e6;
    if (reste > .5) reste = .5;
    _avant = ecoule;
    final vise = widget.navigationShell.currentIndex.toDouble();
    while (reste > 0) {
      final dt = reste < 1 / 60 ? reste : 1 / 60;
      _vitesse += (240 * (vise - _position.value) - 25 * _vitesse) * dt;
      _position.value += _vitesse * dt;
      reste -= dt;
    }
  });

  @override
  void dispose() {
    _temps.dispose();
    _ticker.dispose();
    _position.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: _BarreOnglet(
        programme: _programme,
        index: widget.navigationShell.currentIndex,
        onTap: (int index) => widget.navigationShell.goBranch(index),
        temps: _temps,
        position: _position,
      ),
    );
  }
}

class _BarreOnglet extends StatelessWidget {
  static const _onglets = [
    (icone: 'assets/icon/accueil.svg', libelle: 'Accueil'),
    (icone: 'assets/icon/routine.svg', libelle: 'Routine'),
    (icone: 'assets/icon/scan.svg', libelle: 'Scanner'),
    (icone: 'assets/icon/discussion.svg', libelle: 'Discussion'),
    (icone: 'assets/icon/profil.svg', libelle: 'Profil'),
  ];

  const _BarreOnglet({
    required this.programme,
    required this.index,
    required this.onTap,
    required this.temps,
    required this.position,
  });

  final ui.FragmentProgram? programme;
  final int index;
  final ValueChanged<int> onTap;

  final ValueNotifier<double> temps;
  final ValueNotifier<double> position;

  @override
  Widget build(BuildContext context) {
    final prog = programme;
    return LayoutBuilder(
      builder: (context, contraints) {
        // La maquette est dessinée pour un écran de 390 px de large : tout se met à l'échelle.
        final e = (contraints.maxWidth / 390).clamp(.85, 1.25);
        final largeurOnglet =
            (contraints.maxWidth - 2 * 14 * e) / _onglets.length;

        // Les icônes et les textes ne bougent pas avec le temps : construits une fois, passés en child.
        final icones = SizedBox(
          height: 86 * e,

          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 14 * e),
            child: Row(
              children: [
                for (final (i, onglet) in _onglets.indexed)
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onTap(i),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 14 * e),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Opacity(
                              opacity: i == index ? 0 : 1,
                              child: SvgPicture.asset(
                                onglet.icone,
                                width: 24 * e,
                                height: 24 * e,
                                colorFilter: const ColorFilter.mode(
                                  RevelaColors.encre2,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),

                            SizedBox(height: 3 * e),
                            Text(
                              onglet.libelle,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: i == index
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: i == index
                                    ? RevelaColors.accentFort
                                    : RevelaColors.encre2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );

        return AnimatedBuilder(
          animation: Listenable.merge([temps, position]),
          child: icones,
          builder: (context, icones) {
            // position compte en onglets (1.6 = entre Routine et Scanner) : on la traduit en pixels.
            final x = 14 * e + largeurOnglet * (position.value + .5);
            return SizedBox(
              height: 130 * e,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: CustomPaint(
                      painter: _FormeBarre(x: x, echelle: e),
                      child: icones,
                    ),
                  ),
                  if (prog != null)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: CustomPaint(
                          painter: _BullePainter(
                            programme: prog,
                            x: x,
                            echelle: e,
                            t: temps.value,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: x - 27 * e,
                    top: 20 * e,
                    width: 54 * e,
                    height: 54 * e,
                    child: IgnorePointer(
                      child: Center(
                        child: SvgPicture.asset(
                          _onglets[index].icone,
                          width: 24 * e,
                          height: 24 * e,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _FormeBarre extends CustomPainter {
  const _FormeBarre({required this.x, required this.echelle});

  final double x;
  final double echelle;

  @override
  void paint(Canvas canvas, Size size) {
    final forme = Path()
      ..moveTo(-1000, 0)
      ..lineTo(-50, 0)
      ..cubicTo(-36, 0, -33, 7, -28, 17)
      ..cubicTo(-21, 33, -12, 39, 0, 39)
      ..cubicTo(12, 39, 21, 33, 28, 17)
      ..cubicTo(33, 7, 36, 0, 50, 0)
      ..lineTo(1000, 0)
      ..lineTo(1000, size.height / echelle)
      ..lineTo(-1000, size.height / echelle)
      ..close();
    canvas.clipRect(Offset.zero & size);
    canvas.translate(x, 0);
    canvas.scale(echelle);
    canvas.drawPath(forme, Paint()..color = RevelaColors.blanc);
  }

  @override
  bool shouldRepaint(_FormeBarre oldDelegate) =>
      oldDelegate.x != x || oldDelegate.echelle != echelle;
}

class _BullePainter extends CustomPainter {
  _BullePainter({
    required this.programme,
    required this.x,
    required this.echelle,
    required this.t,
  });

  final ui.FragmentProgram programme;
  final double x; // centre de l'onglet actif
  final double echelle;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    // Repère de la maquette : y compté depuis le bas, centre à 47 px du haut.
    final y = size.height - 47 * echelle;
    final shader = programme.fragmentShader()
      ..setFloat(0, size.height) // uH
      ..setFloat(1, t) // uT
      ..setFloat(2, .1) // uIri
      ..setFloat(3, 1) // uK
      ..setFloat(4, .6) // uWob
      ..setFloat(5, 0) // uLum
      ..setFloat(6, 1) // uTeinte
      ..setFloat(7, x) // uA.x
      ..setFloat(8, y) // uA.y
      ..setFloat(9, 27 * echelle) // uA.rayon
      ..setFloat(10, .75) // uA.pointe
      ..setFloat(11, x) // uB.x
      ..setFloat(12, y - 2 * echelle) // uB.y
      ..setFloat(13, 0) // uB.rayon : pas de deuxième goutte au repos
      ..setFloat(14, 0) // uB.pointe
      ..setFloat(15, 0) // uDoigt.x
      ..setFloat(16, 0) // uDoigt.y
      ..setFloat(17, 0) // uDoigt.force
      ..setFloat(18, x) // uOnde.x
      ..setFloat(19, y) // uOnde.y
      ..setFloat(20, 9); // uOnde.âge : > 2.5, donc pas d'onde
    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(_BullePainter old) =>
      old.x != x || old.echelle != echelle || old.t != t;
}

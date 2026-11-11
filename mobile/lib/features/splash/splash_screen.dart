import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/revela_colors.dart';

/// Splash « Le lac » : dix gouttes tombent dans un lac rose,
/// la 10e est une goutte d'encre qui dessine « revela ».
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  /// Durée totale de l'animation, la valeur END du shader.
  static const _duree = 4.6;

  late final AnimationController _temps = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 4600),
  );

  ui.FragmentProgram? _programme;
  ui.Image? _logo;
  ui.Image? _flou;

  @override
  void initState() {
    super.initState();
    _charger();
  }

  Future<ui.Image> _image(String chemin) async {
    final donnees = await rootBundle.load(chemin);
    final codec = await ui.instantiateImageCodec(donnees.buffer.asUint8List());
    return (await codec.getNextFrame()).image;
  }

  Future<void> _charger() async {
    final programme = await ui.FragmentProgram.fromAsset('shaders/lac.frag');
    final logo = await _image('assets/splash/revela.png');
    final flou = await _image('assets/splash/revela-flou.png');
    if (!mounted) return;
    setState(() {
      _programme = programme;
      _logo = logo;
      _flou = flou;
    });

    // Animations désactivées dans le téléphone (accessibilité) : on montre le nom tout de suite.
    if (MediaQuery.disableAnimationsOf(context)) {
      _temps.value = 1;
      await Future<void>.delayed(const Duration(milliseconds: 900));
      _continuer();
      return;
    }
    _temps.forward().whenComplete(_continuer);
  }

  void _continuer() {
    if (mounted) context.go('/accueil');
  }

  @override
  void dispose() {
    _temps.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final programme = _programme;
    return Scaffold(
      backgroundColor: RevelaColors.perle,
      body: GestureDetector(
        onTap: _continuer,
        child: programme == null
            ? const SizedBox.expand()
            : AnimatedBuilder(
          animation: _temps,
          builder: (context, _) => CustomPaint(
            size: Size.infinite,
            painter: _LacPainter(programme, _logo!, _flou!, _temps.value * _duree),
          ),
        ),
      ),
    );
  }
}

/// Dessine le shader du lac sur tout l'écran.
class _LacPainter extends CustomPainter {
  _LacPainter(this.programme, this.logo, this.flou, this.t);

  final ui.FragmentProgram programme;
  final ui.Image logo;
  final ui.Image flou;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    // Les index suivent l'ordre des uniforms dans shaders/lac.frag.
    final shader = programme.fragmentShader()
      ..setFloat(0, size.width) // uSize.x
      ..setFloat(1, size.height) // uSize.y
      ..setFloat(2, t) // uT
      ..setFloat(3, logo.width / logo.height) // uAsp
      ..setImageSampler(0, logo) // uLogo
      ..setImageSampler(1, flou); // uBlur
    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(_LacPainter old) => old.t != t;
}

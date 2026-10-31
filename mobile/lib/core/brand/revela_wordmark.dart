import 'package:flutter/material.dart';

/// The REVELA wordmark, constructed capitals — same shapes as WORDMARK in brand/build.py.
/// Never set the name in a font instead.
class RevelaWordmark extends StatelessWidget {
  const RevelaWordmark({super.key, this.height = 24, this.color});

  /// Cap height in logical pixels.
  final double height;

  /// Defaults to the theme's onSurface.
  final Color? color;

  static const _width = 609.2, _top = 62.0, _boxHeight = 132.0, _cap = 128.0;

  @override
  Widget build(BuildContext context) {
    final s = height / _cap;
    return Semantics(
      label: 'Revela',
      child: CustomPaint(
        size: Size(_width * s, _boxHeight * s),
        painter: _WordmarkPainter(color ?? Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}

class _WordmarkPainter extends CustomPainter {
  _WordmarkPainter(this.color);

  final Color color;

  static final List<Path> _shapes = _build();

  static List<Path> _build() {
    Path poly(List<double> p) {
      final path = Path()..moveTo(p[0], p[1]);
      for (var i = 2; i < p.length; i += 2) {
        path.lineTo(p[i], p[i + 1]);
      }
      return path..close();
    }

    Path e(double x) => poly([
      x,
      64,
      x + 70,
      64,
      x + 70,
      75,
      x + 11,
      75,
      x + 11,
      122.5,
      x + 62,
      122.5,
      x + 62,
      133.5,
      x + 11,
      133.5,
      x + 11,
      181,
      x + 70,
      181,
      x + 70,
      192,
      x,
      192,
    ]);

    final bowl = Path()
      ..fillType = PathFillType.evenOdd
      ..moveTo(0, 64)
      ..lineTo(40, 64)
      ..arcToPoint(const Offset(40, 141), radius: const Radius.circular(38.5))
      ..lineTo(0, 141)
      ..close()
      ..moveTo(11, 75)
      ..lineTo(40, 75)
      ..arcToPoint(const Offset(40, 130), radius: const Radius.circular(27.5))
      ..lineTo(11, 130)
      ..close();

    return [
      Path()..addRect(const Rect.fromLTWH(0, 64, 11, 128)),
      bowl,
      poly([34, 130, 46.5, 130, 82.3, 192, 69.8, 192]), // R leg at 60°
      e(120),
      poly([230, 64, 241.39, 64, 264.3, 149.5, 287.21, 64, 298.6, 64, 264.3, 194]), // V at 75°
      e(338.6),
      poly([448.6, 64, 459.6, 64, 459.6, 181, 512.6, 181, 512.6, 192, 448.6, 192]),
      poly([540.6, 192, 551.99, 192, 574.9, 106.5, 597.81, 192, 609.2, 192, 574.9, 62]),
      Path()..addOval(Rect.fromCircle(center: const Offset(574.9, 166), radius: 7)), // the pearl
    ];
  }

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / RevelaWordmark._width;
    canvas.scale(s);
    canvas.translate(0, -RevelaWordmark._top);
    final paint = Paint()..color = color;
    for (final shape in _shapes) {
      canvas.drawPath(shape, paint);
    }
  }

  @override
  bool shouldRepaint(_WordmarkPainter old) => old.color != color;
}

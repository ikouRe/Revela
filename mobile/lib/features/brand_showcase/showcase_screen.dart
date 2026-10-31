import 'package:flutter/material.dart';

import '../../core/brand/press_scale.dart';
import '../../core/brand/revela_mark.dart';
import '../../core/brand/revela_wordmark.dart';
import '../../core/brand/verdict.dart';
import '../../core/brand/verdict_indicator.dart';
import '../../core/theme/revela_colors.dart';
import '../../core/theme/revela_motion.dart';

/// Temporary brand showcase until the real onboarding lands (REV-12).
class ShowcaseScreen extends StatefulWidget {
  const ShowcaseScreen({super.key});

  @override
  State<ShowcaseScreen> createState() => _ShowcaseScreenState();
}

class _ShowcaseScreenState extends State<ShowcaseScreen> {
  Verdict _verdict = Verdict.compatible;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
          children: [
            const Row(children: [RevelaMark(size: 56), SizedBox(width: 16), RevelaWordmark(height: 18)]),
            const SizedBox(height: 40),
            Text('Ce que ce produit\nrévèle pour toi.', style: text.displayMedium),
            const SizedBox(height: 40),
            _Section(
              title: 'VERDICT',
              child: Column(
                children: [
                  Center(child: VerdictIndicator(verdict: _verdict)),
                  const SizedBox(height: 20),
                  VerdictBadge(verdict: _verdict),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      for (final v in Verdict.values)
                        PressScale(
                          onTap: () => setState(() => _verdict = v),
                          child: _Chip(label: v.name.toUpperCase(), selected: v == _verdict),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const _Section(
              title: 'COULEURS',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _Swatch('Ultraviolet', RevelaColors.uv),
                  _Swatch('Nuit', RevelaColors.nuit),
                  _Swatch('Nacre', RevelaColors.nacre),
                  _Swatch('Pêche', RevelaColors.peche),
                ],
              ),
            ),
            _Section(
              title: 'TYPOGRAPHIE',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Instrument Serif', style: text.headlineLarge),
                  const SizedBox(height: 4),
                  Text('Manrope — l\'interface, les listes, les ingrédients.', style: text.bodyLarge),
                ],
              ),
            ),
            Text(
              'Revela donne une information, pas un avis médical. '
              'En cas de réaction, consulte un dermatologue.',
              style: text.bodyMedium?.copyWith(color: text.bodyMedium?.color?.withValues(alpha: 0.6)),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: RevelaMotion.select,
      curve: RevelaMotion.easeOut,
      constraints: const BoxConstraints(minHeight: 44), // touch target
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? scheme.onSurface : Colors.transparent,
        border: Border.all(color: scheme.onSurface.withValues(alpha: selected ? 1 : 0.2)),
        borderRadius: BorderRadius.circular(999),
      ),
      // The label fades with the fill, or it would vanish against it for 180 ms.
      child: AnimatedDefaultTextStyle(
        duration: RevelaMotion.select,
        curve: RevelaMotion.easeOut,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: selected ? scheme.surface : scheme.onSurface),
        child: Text(label),
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch(this.name, this.color);

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final hex = '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
          ),
        ),
        const SizedBox(height: 6),
        Text(name, style: Theme.of(context).textTheme.labelLarge),
        Text(hex, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

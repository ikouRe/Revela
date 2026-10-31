import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revela/core/brand/verdict.dart';
import 'package:revela/core/brand/verdict_indicator.dart';
import 'package:revela/core/theme/revela_motion.dart';
import 'package:revela/core/theme/revela_route.dart';
import 'package:revela/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('lens colour', () {
    test('a result arriving from INCONNU keeps its own colour all the way in', () {
      for (final d in [130.0, 100.0, 90.0, 72.0, 50.0, 44.0]) {
        expect(
          VerdictIndicator.lensColor(Verdict.inconnu, Verdict.compatible, d),
          Verdict.compatible.color,
          reason: '$d',
        );
      }
    });

    test('leaving to INCONNU keeps the previous colour while the lens shrinks', () {
      expect(VerdictIndicator.lensColor(Verdict.compatible, Verdict.inconnu, 100), Verdict.compatible.color);
    });

    test('between two known verdicts the colour travels through the scale', () {
      expect(VerdictIndicator.lensColor(Verdict.compatible, Verdict.deconseille, 72), Verdict.prudence.color);
    });
  });

  group('haptic', () {
    late List<String> calls;
    setUp(() {
      calls = [];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'HapticFeedback.vibrate') calls.add(call.arguments as String);
          return null;
        },
      );
    });

    Widget host(Widget child) => MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );

    testWidgets('one light impact when the rings land', (tester) async {
      await tester.pumpWidget(host(const VerdictIndicator(verdict: Verdict.compatible)));
      await tester.pumpAndSettle();
      expect(calls, ['HapticFeedbackType.lightImpact']);
    });

    testWidgets('animate: false shows the result with no haptic', (tester) async {
      await tester.pumpWidget(host(const VerdictIndicator(verdict: Verdict.compatible, animate: false)));
      await tester.pumpAndSettle();
      expect(calls, isEmpty);
    });
  });

  testWidgets('later launches skip the splash entirely', (tester) async {
    SharedPreferences.setMockInitialValues({'splash_seen': true});
    await tester.pumpWidget(const RevelaApp());
    await tester.pump(); // prefs resolve
    await tester.pump(); // the zero-length route lands
    expect(find.text(Verdict.compatible.label), findsOneWidget);
  });

  testWidgets('RevelaPageRoute pushes in 350 ms, fades in 300 ms with reduced motion', (tester) async {
    late NavigatorState nav;
    Future<void> pumpApp(bool reduced) => tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(disableAnimations: reduced),
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              nav = Navigator.of(context);
              return const SizedBox();
            },
          ),
        ),
      ),
    );

    await pumpApp(false);
    final push = RevelaPageRoute<void>(builder: (_) => const Text('next'));
    nav.push(push);
    await tester.pumpAndSettle();
    expect(push.transitionDuration, RevelaMotion.push);

    await pumpApp(true);
    final fade = RevelaPageRoute<void>(builder: (_) => const Text('next'));
    nav.push(fade);
    await tester.pumpAndSettle();
    expect(fade.transitionDuration, RevelaMotion.routeFade);
  });
}

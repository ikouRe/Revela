import 'package:flutter_test/flutter_test.dart';
import 'package:revela/core/brand/verdict.dart';
import 'package:revela/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('first launch plays the splash, then opens the showcase', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const RevelaApp());
    for (var i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 100)); // splash, hold, then the fade route
    }
    await tester.pumpAndSettle();
    expect(find.text(Verdict.compatible.label), findsOneWidget);
    expect((await SharedPreferences.getInstance()).getBool('splash_seen'), isTrue);
  });

  testWidgets('switching verdict updates the RG-37 label', (tester) async {
    SharedPreferences.setMockInitialValues({'splash_seen': true});
    await tester.pumpWidget(const RevelaApp());
    for (var i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 100)); // splash, hold, then the fade route
    }
    await tester.pumpAndSettle();
    await tester.tap(find.text('PRUDENCE'));
    await tester.pumpAndSettle();
    expect(find.text(Verdict.prudence.label), findsOneWidget);
  });
}

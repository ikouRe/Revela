import 'package:flutter_test/flutter_test.dart';
import 'package:revela/main.dart';

void main() {
  testWidgets("l'app démarre", (tester) async {
    await tester.pumpWidget(const RevelaApp());
    expect(find.text('Revela'), findsOneWidget);
  });
}

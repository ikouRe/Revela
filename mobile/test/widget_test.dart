import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revela/main.dart';

void main() {
  testWidgets("l'app démarre sur l'accueil avec les 5 onglets", (tester) async {
    await tester.pumpWidget(const RevelaApp());
    await tester.pumpAndSettle();

    final barre = tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
    expect(barre.items.length, 5);
    expect(barre.currentIndex, 0);
  });

  testWidgets("taper sur Scanner ouvre l'onglet Scanner", (tester) async {
    await tester.pumpWidget(const RevelaApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Scanner'));
    await tester.pumpAndSettle();

    final barre = tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
    expect(barre.currentIndex, 2);
  });
}

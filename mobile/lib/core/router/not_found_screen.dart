import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Affiché quand l'adresse demandée n'existe pas dans le routeur.
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Page introuvable'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/accueil'),
              child: const Text("Retour à l'accueil"),
            ),
          ],
        ),
      ),
    );
  }
}

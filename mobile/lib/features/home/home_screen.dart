import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text('Accueil', style: Theme.of(context).textTheme.displayLarge),
        ),);
  }
}

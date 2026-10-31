import 'package:flutter/material.dart';

import 'core/theme/revela_theme.dart';
import 'features/brand_showcase/showcase_screen.dart';
import 'features/splash/splash_screen.dart';

void main() {
  runApp(const RevelaApp());
}

class RevelaApp extends StatelessWidget {
  const RevelaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revela',
      debugShowCheckedModeBanner: false,
      theme: RevelaTheme.light(),
      darkTheme: RevelaTheme.dark(),
      home: SplashScreen(next: (_) => const ShowcaseScreen()),
    );
  }
}

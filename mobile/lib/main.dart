import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:revela/core/router/app_router.dart';

import 'core/theme/revela_theme.dart';

void main() => runApp(const ProviderScope(child:RevelaApp()));

class RevelaApp extends StatelessWidget {
  const RevelaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Revela',
      theme: revelaTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig:appRouter,
    );
  }
}

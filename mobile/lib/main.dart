import 'package:flutter/material.dart';

void main() => runApp(const RevelaApp());

class RevelaApp extends StatelessWidget {
  const RevelaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Revela',
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: Text('Revela'))),
    );
  }
}

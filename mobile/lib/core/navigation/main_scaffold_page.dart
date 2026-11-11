import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffoldPage extends StatefulWidget {
  const MainScaffoldPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainScaffoldPage> createState() => _MainScaffoldPageState();
}

class _MainScaffoldPageState extends State<MainScaffoldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.event_note_outlined), label: 'Routine'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scanner'),
          BottomNavigationBarItem(icon: Icon(Icons.forum_outlined), label: 'Discussion'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (int index)=> widget.navigationShell.goBranch(index),
      ),
    );
  }
}

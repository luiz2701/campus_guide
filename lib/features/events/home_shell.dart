import 'package:flutter/material.dart';

import '../../Components/navigation/bottom_nav_bar.dart';
import 'home.dart';
import 'create_page.dart';
import 'my_events_page.dart';
import 'package:campus_guide/features/profile/profile_page.dart';

/// Container que mantém as principais abas e a `AppBottomNavBar`.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int currentIndex = 0;

  /// Incrementado toda vez que a aba Home (índice 0) fica visível.
  /// `HomePage` observa esse valor via `didUpdateWidget` e recarrega os eventos.
  int _homeReloadToken = 0;

  void _onTabTap(int i) {
    setState(() {
      if (i == 0) _homeReloadToken++;
      currentIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomePage(reloadToken: _homeReloadToken),
      const CreatePage(),
      const MyEventsPage(),
      const ProfilePage(showBottomNavigationBar: false),
    ];

    return Scaffold(
      // `IndexedStack` preserva o estado de cada aba ao alternar.
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentIndex,
        onTap: _onTabTap,
      ),
    );
  }
}

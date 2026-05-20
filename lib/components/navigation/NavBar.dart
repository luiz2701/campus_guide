import 'package:flutter/material.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool showCreateButton;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showCreateButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: "Home",
      ),
      if (showCreateButton)
        const BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          activeIcon: Icon(Icons.add_circle),
          label: "Criar",
        ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month_outlined),
        activeIcon: Icon(Icons.calendar_month),
        label: "Eventos",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        activeIcon: Icon(Icons.person),
        label: "Perfil",
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),

        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),

      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,

        type: BottomNavigationBarType.fixed,

        backgroundColor: Colors.transparent,

        elevation: 0,

        selectedItemColor: const Color(0xFF3B5EDF),

        unselectedItemColor: Colors.black54,

        items: items,
      ),
    );
  }
}
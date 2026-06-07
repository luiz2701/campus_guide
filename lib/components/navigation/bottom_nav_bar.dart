import 'package:flutter/material.dart';

/// Bottom Navigation Bar do app
/// Ícones de navegação principais.
/// O item selecionado ganha efeito azul em volta
/// O texto do item aparece apenas quando selecionado, assim como o protótipo do figma
/// Animações de transição entre os ícones

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  Widget _buildItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF3B5EDF) : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.white : Colors.black54),

          if (isSelected) ...[
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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

        showSelectedLabels: false,
        showUnselectedLabels: false,

        selectedItemColor: const Color(0xFF3B5EDF),
        unselectedItemColor: Colors.black54,

        items: [
          BottomNavigationBarItem(
            icon: _buildItem(Icons.home_outlined, "Home", 0),
            activeIcon: _buildItem(Icons.home, "Home", 0),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: _buildItem(Icons.add_circle_outline, "Criar", 1),
            activeIcon: _buildItem(Icons.add_circle, "Criar", 1),
            label: "Criar",
          ),

          BottomNavigationBarItem(
            icon: _buildItem(Icons.calendar_month_outlined, "Eventos", 2),
            activeIcon: _buildItem(Icons.calendar_month, "Eventos", 2),
            label: "Eventos",
          ),

          BottomNavigationBarItem(
            icon: _buildItem(Icons.person_outline, "Perfil", 3),
            activeIcon: _buildItem(Icons.person, "Perfil", 3),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}

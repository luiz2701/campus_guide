import 'package:flutter/material.dart';

import "components/navigation/NavBar.dart";
import 'components/cards/EventCard.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 85, 151),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Olá Aluno', style: TextStyle(color: Colors.white)),
            const Text(
              "Eventos",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            EventCard(
              title: "TechConnect 2026",
              date: "03\nABR",
              description:
                  "Evento de tecnologia e inovação com palestras e workshops.",
              onTap: () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 0,
        onTap: (index) {},
        showCreateButton: false,
      ),
    );
  }
}

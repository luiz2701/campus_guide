import 'package:flutter/material.dart';

import 'main.dart';
import 'components/navigation/Nav_Bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 4, 85, 151),
        body: SafeArea(
          child: Column(
            children: [
              const Text('Olá Docente', style: TextStyle(color: Colors.white)),
              const Text(
                "Cards",
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
              AppBottomNavBar(
                currentIndex: 0,
                onTap: (index) {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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
              EventDetailsCard(
                title: "TechConnect 2026: Do Código ao Mercado",
                description:
                    "Uma palestra focada em quem quer sair da teoria e entrar no jogo de verdade.",
                location: "Auditório Padre Arnobio",
                remainingVacancies: 30,
                isOpen: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: Text(date),
        onTap: onTap,
      ),
    );
  }
}

class EventDetailsCard extends StatelessWidget {
  final String title;
  final String description;
  final String location;
  final int remainingVacancies;
  final bool isOpen;

  const EventDetailsCard({
    super.key,
    required this.title,
    required this.description,
    required this.location,
    required this.remainingVacancies,
    required this.isOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 8),
            Text('Location: $location'),
            const SizedBox(height: 8),
            Text('Remaining vacancies: $remainingVacancies'),
            const SizedBox(height: 8),
            Text(isOpen ? 'Open' : 'Closed'),
          ],
        ),
      ),
    );
  }
}



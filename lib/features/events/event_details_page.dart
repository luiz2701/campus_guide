import 'package:flutter/material.dart';

import '../../components/cards/event_details_card.dart';

class EventDetailsPage extends StatelessWidget {
  final String title;
  final String description;
  final String location;

  final List<Map<String, String>> speakers;

  const EventDetailsPage({
    super.key,
    required this.title,
    required this.description,
    required this.location,
    required this.speakers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F49D1),

      appBar: AppBar(
        backgroundColor: const Color(0xFF2F49D1),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: EventDetailsCard(
          title: title,
          description: description,
          location: location,

          remainingVacancies: 0,

          isOpen: false,

          showVacancies: false,

          speakers: speakers,
        ),
      ),
    );
  }
}

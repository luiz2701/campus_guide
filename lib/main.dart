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
        body: const SafeArea(child: Text('Olá Docente', style: TextStyle(color: Colors.white)))
        
      ),
    );
  }
}


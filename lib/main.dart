import 'package:flutter/material.dart';

import 'home.dart';
import 'Home(aluno).dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Guide',
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final userRole = 'aluno'; 
    
    if (userRole == 'aluno') {
      return const StudentHomeScreen();
    }
    return const TeacherHomeScreen();
  }
}







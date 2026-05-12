import 'package:campus_guide/login/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Projeto()));
}

class Projeto extends StatelessWidget {
  const Projeto({super.key});

  @override
  Widget build(BuildContext context) {
      return (
       Login()
      );
      
  }
}

import 'package:campus_guide/login/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    theme: ThemeData(
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,),
        headlineMedium: TextStyle(fontSize: 22,),
        titleLarge: TextStyle(fontSize: 20),
        labelLarge: TextStyle(fontSize: 22)
      )
    ),
    home: Projeto()));
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




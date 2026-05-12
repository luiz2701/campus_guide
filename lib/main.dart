import 'package:campus_guide/login/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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




import 'package:flutter/material.dart';

import '/components/buttons/primary_button.dart';
import 'components/buttons/secondary_button.dart';
import 'components/buttons/danger_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ButtonsPreviewPage(),
    );
  }
}

class ButtonsPreviewPage extends StatelessWidget {
  const ButtonsPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F49D1),
      appBar: AppBar(
        title: const Text("Preview Buttons"),
        backgroundColor: const Color(0xFF2F49D1),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            PrimaryButton(
              text: "Entrar",
              onPressed: () {
                print("PrimaryButton");
              },
            ),

            const SizedBox(height: 20),

            SecondaryButton(
              text: "Cancelar",
              onPressed: () {
                print("SecondaryButton");
              },
            ),

            const SizedBox(height: 20),

            DangerButton(
              text: "Excluir Evento",
              onPressed: () {
                print("DangerButton");
              },
            ),

            const SizedBox(height: 20),

            PrimaryButton(
              text: "Carregando...",
              loading: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
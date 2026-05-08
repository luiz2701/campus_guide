import 'package:flutter/material.dart';

import 'components/buttons/danger_button.dart';
import 'components/buttons/primary_button.dart';
import 'components/buttons/secondary_button.dart';

import 'components/inputs/app_text_field.dart';
import 'components/inputs/password_field.dart';
import 'components/inputs/search_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ComponentsPreviewPage(),
    );
  }
}

class ComponentsPreviewPage extends StatefulWidget {
  const ComponentsPreviewPage({super.key});

  @override
  State<ComponentsPreviewPage> createState() =>
      _ComponentsPreviewPageState();
}

class _ComponentsPreviewPageState
    extends State<ComponentsPreviewPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F49D1),

      appBar: AppBar(
        title: const Text("Testando Componentes"),
        backgroundColor: const Color(0xFF2F49D1),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Inputs",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            AppTextField(
              hint: "Email",
              controller: emailController,
            ),

            const SizedBox(height: 20),

            PasswordField(
              hint: "Senha",
              controller: passwordController,
            ),

            const SizedBox(height: 20),

            SearchField(
              controller: searchController,
            ),

            const SizedBox(height: 40),

            const Text(
              "Buttons",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            PrimaryButton(
              text: "Entrar",
              onPressed: () {},
            ),

            const SizedBox(height: 20),

            SecondaryButton(
              text: "Cancelar",
              onPressed: () {},
            ),

            const SizedBox(height: 20),

            DangerButton(
              text: "Excluir Evento",
              onPressed: () {},
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
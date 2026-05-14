import 'package:flutter/material.dart';

import '../../components/buttons/primary_button.dart';
import '../../components/dialogs/success_dialog.dart';
import '../../components/inputs/app_text_field.dart';
import '../../components/inputs/password_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController(
    text: "Pedro Alves Santana de Souza",
  );

  final matriculaController = TextEditingController(text: "202312345");

  final passwordController = TextEditingController(text: "12345678");

  String savedName = "Pedro Alves Santana de Souza";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Editar Perfil"),

        backgroundColor: Colors.white,

        foregroundColor: Colors.black,

        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(
              child: Container(
                width: 120,
                height: 120,

                decoration: const BoxDecoration(
                  color: Color(0xFF0D4DB3),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              "Nome",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 10),

            AppTextField(hint: "Nome", controller: nameController),

            const SizedBox(height: 24),

            const Text(
              "Matrícula",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 10),

            AppTextField(
              hint: "Matrícula",
              controller: matriculaController,
              enabled: false,
            ),

            const SizedBox(height: 24),

            const Text(
              "Senha Atual",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 10),

            PasswordField(
              hint: "Senha",
              controller: passwordController,
              enabled: false,
            ),

            const Spacer(),

            PrimaryButton(
              text: "Salvar Alterações",

              onPressed: () {
                setState(() {
                  savedName = nameController.text;
                });

                SuccessDialog.show(
                  context,

                  title: "Perfil atualizado",

                  message: "As alterações foram salvas com sucesso.",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

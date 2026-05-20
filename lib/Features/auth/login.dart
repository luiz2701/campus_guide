/*
  Tela de login do aplicativo.

  Contém o formulário de autenticação (email + senha) usado apenas como
  placeholder/local para demonstração. Valida os campos localmente e, em caso
  de sucesso, navega para a rota inicial do aplicativo usando
  `Navigator.pushReplacementNamed(context, AppRoutes.home)`.

  Uso:
  - Navegar para a tela de registro: `Navigator.pushNamed(context, AppRoutes.register)`
  - Após login bem-sucedido: `Navigator.pushReplacementNamed(context, AppRoutes.home)`
*/
import 'package:campus_guide/routes/app_routes.dart';
import 'package:flutter/material.dart';

/// Widget que representa a tela de login.
///
/// - Exibe os campos de `email` e `senha` (controladores: `emailController`,
///   `senhalController`).
/// - O botão de confirmação valida o formulário e executa a navegação.
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController senhalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'imagens/CampusGuide_png.png',
                    width: 250,

                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                width: 350,
                height: 600,
                padding: EdgeInsets.only(top: 40),
                margin: EdgeInsets.zero,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: (Form(
                    key: _formkey,

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 17, bottom: 20),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Entrar',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayLarge,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Não tem uma conta?',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.only(
                                          bottom: 0,
                                          top: 0,
                                          right: 0,
                                          left: 3,
                                        ),
                                        overlayColor: Colors.transparent,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        foregroundColor: Color.fromARGB(
                                          255,
                                          48,
                                          60,
                                          231,
                                        ),
                                      ),
                                      child: Text(
                                        'inscreva-se',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.register,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Opacity(
                          opacity: 0.2,
                          child: TextFormField(
                            controller: emailController,

                            decoration: InputDecoration(
                              labelText: 'Email (Institucional)',
                              labelStyle: TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'digite seu email';
                              }

                              if (value != 'jose@gmail.com') {
                                return 'Email invalido';
                              }

                              return null;
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 12, top: 12),
                          child: Opacity(
                            opacity: 0.2,
                            child: TextFormField(
                              controller: senhalController,

                              decoration: InputDecoration(
                                labelText: 'Senha',
                                labelStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Digite sua senha';
                                }

                                if (value != '1234') {
                                  return 'senha invalida';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),

                        Container(
                          width: 500,
                          height: 45,

                          child: ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.home,
                                );
                              }
                            },

                            child: Text(
                              'Avançar',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 48, 60, 231),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.only(
                              top: 14,
                              bottom: 0,
                              right: 0,
                              left: 0,
                            ),
                            overlayColor: Colors.transparent,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            foregroundColor: Color.fromARGB(255, 48, 60, 231),
                          ),
                          child: Text(
                            ' Esqueci minha senha',
                            style: TextStyle(fontSize: 12),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

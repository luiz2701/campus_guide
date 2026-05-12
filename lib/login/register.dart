import 'package:campus_guide/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'popups.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController senhaController = TextEditingController();

  final TextEditingController matriculaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flexible(
        child: SingleChildScrollView(
          child: Center(
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
                  Center(
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: 350,
                      height: 600,
                      padding: EdgeInsets.only(top: 40),
                      child: (Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 17,
                                bottom: 20,
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: Text(
                                        'Cadastre-se',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Já tem uma conta?',
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
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            foregroundColor: Color.fromARGB(
                                              255,
                                              48,
                                              60,
                                              231,
                                            ),
                                          ),
                                          child: Text(
                                            'Entre',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,

                                              MaterialPageRoute(
                                                builder: (context) => Login(),
                                              ),
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
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],

                                controller: matriculaController,

                                decoration: InputDecoration(
                                  labelText: 'Matrícula',
                                  labelStyle: TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'digite sua matrícula';
                                  }

                                  if (value.length < 11) {
                                    return 'Matrícula invalida';
                                  }

                                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                    return 'Digite apenas números';
                                  }

                                  return null;
                                },
                              ),
                            ),

                            SizedBox(height: 20),

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
                                    return 'digite o email';
                                  }

                                  if (!value.contains('@')) {
                                    return 'Email invalido';
                                  }

                                  return null;
                                },
                              ),
                            ),

                            SizedBox(height: 20),

                            Opacity(
                              opacity: 0.2,
                              child: TextFormField(
                                controller: senhaController,

                                decoration: InputDecoration(
                                  labelText: 'Senha',
                                  labelStyle: TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Digite a senha';
                                  }

                                  return null;
                                },
                              ),
                            ),

                            SizedBox(height: 20),

                            SizedBox(
                              width: 500,
                              height: 45,

                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    Popups popup = Popups();
                                    popup.esperandoConfirmacao(context);
                                  }
                                },
                                child: Text('Avançar'),
                                style: TextButton.styleFrom(
                                  backgroundColor: Color.fromARGB(
                                    255,
                                    48,
                                    60,
                                    231,
                                  ),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
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
        ),
      ),
    );
  }
}

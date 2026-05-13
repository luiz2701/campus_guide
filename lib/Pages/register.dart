import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campus_guide/Collections/institutional_db.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _matriculaCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _loading = false;
  String? _feedbackMessage;
  bool _feedbackIsError = false;

  @override
  void dispose() {
    _matriculaCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  String? _validateMatricula(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe a matrícula.';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe o email.';
    final isValid = RegExp(
      r'^[\w.+-]+@[\w-]+(\.[a-zA-Z]{2,})+$',
    ).hasMatch(value.trim());
    if (!isValid) return 'Email inválido.';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Informe a senha.';
    if (value.length < 6) return 'A senha deve ter ao menos 6 caracteres.';
    return null;
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _feedbackMessage = null;
    });

    final matricula = _matriculaCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;

    try {
      final record = InstitutionalDB.validate(
        matricula: matricula,
        email: email,
      );

      final db = FirebaseFirestore.instance;

      final byMatricula = await db
          .collection('users')
          .where('matricula', isEqualTo: matricula)
          .limit(1)
          .get();

      if (byMatricula.docs.isNotEmpty) {
        throw Exception('Esta matrícula já está vinculada a uma conta.');
      }

      final byEmail = await db
          .collection('users')
          .where('email', isEqualTo: email.toLowerCase())
          .limit(1)
          .get();

      if (byEmail.docs.isNotEmpty) {
        throw Exception('Este email já está vinculado a uma conta.');
      }

      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final uid = credential.user!.uid;

      await db.collection('users').doc(uid).set({
        'id': uid,
        'name': record.name,
        'email': email.toLowerCase(),
        'matricula': matricula,
        'role': record.role,
        'createdAt': FieldValue.serverTimestamp(),
      });

      final saved = await db.collection('users').doc(uid).get();

      _showFeedback(
        'Cadastro realizado!\n'
        'Nome: ${saved['name']}\n'
        'Tipo: ${saved['role']}\n'
        'Matrícula: ${saved['matricula']}',
        isError: false,
      );
    } on InstitutionalException catch (e) {
      _showFeedback(e.message, isError: true);
    } on FirebaseAuthException catch (e) {
      _showFeedback(_authErrorMessage(e.code), isError: true);
    } catch (e) {
      _showFeedback(
        e.toString().replaceFirst('Exception: ', ''),
        isError: true,
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showFeedback(String message, {required bool isError}) {
    setState(() {
      _feedbackMessage = message;
      _feedbackIsError = isError;
    });
  }

  String _authErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Este email já está em uso no sistema de autenticação.';
      case 'weak-password':
        return 'Senha muito fraca.';
      case 'invalid-email':
        return 'Email inválido.';
      default:
        return 'Erro de autenticação: $code';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _matriculaCtrl,
                decoration: const InputDecoration(
                  labelText: 'Matrícula',
                  hintText: 'Ex: 20210001 ou DOC001',
                  border: OutlineInputBorder(),
                ),
                validator: _validateMatricula,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Email institucional',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordCtrl,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: _validatePassword,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _register(),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _loading ? null : _register,
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Cadastrar'),
              ),
              if (_feedbackMessage != null) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _feedbackIsError
                        ? Colors.red.shade50
                        : Colors.green.shade50,
                    border: Border.all(
                      color: _feedbackIsError ? Colors.red : Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _feedbackMessage!,
                    style: TextStyle(
                      color: _feedbackIsError
                          ? Colors.red.shade800
                          : Colors.green.shade800,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 32),

              // ── Painel de dados de teste ─────────────────────────────────
              const Divider(),
              const SizedBox(height: 8),
              const Text(
                'Dados disponíveis para teste:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const _TestDataTable(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TestDataTable extends StatelessWidget {
  const _TestDataTable();

  @override
  Widget build(BuildContext context) {
    const rows = [
      ['20210001', 'joao.silva@instituicao.edu.br', 'aluno'],
      ['20210002', 'maria.souza@instituicao.edu.br', 'aluno'],
      ['20210003', 'carlos.mendes@instituicao.edu.br', 'aluno'],
      ['DOC001', 'ana.lima@instituicao.edu.br', 'docente'],
      ['DOC002', 'pedro.costa@instituicao.edu.br', 'docente'],
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16,
        columns: const [
          DataColumn(label: Text('Matrícula')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Tipo')),
        ],
        rows: rows
            .map(
              (r) => DataRow(cells: r.map((c) => DataCell(Text(c))).toList()),
            )
            .toList(),
      ),
    );
  }
}

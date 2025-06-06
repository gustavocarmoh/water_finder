import 'package:flutter/material.dart';

import 'main.dart';

class AguaJaApp extends StatelessWidget {
  const AguaJaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignupPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController = TextEditingController();
  bool _emailError = false;
  bool _senhaError = false;
  bool _confirmaSenhaError = false;
  String? _emailErrorText;
  String? _senhaErrorText;
  String? _confirmaSenhaErrorText;

  void _criarConta() {
    setState(() {
      _emailError = false;
      _senhaError = false;
      _confirmaSenhaError = false;
      _emailErrorText = null;
      _senhaErrorText = null;
      _confirmaSenhaErrorText = null;
    });
    bool isValid = true;
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      _emailError = true;
      _emailErrorText = 'E-mail inválido';
      isValid = false;
    }
    if (_senhaController.text.isEmpty || _senhaController.text.length < 4) {
      _senhaError = true;
      _senhaErrorText = 'Senha muito curta';
      isValid = false;
    }
    if (_confirmaSenhaController.text != _senhaController.text) {
      _confirmaSenhaError = true;
      _confirmaSenhaErrorText = 'As senhas não coincidem';
      isValid = false;
    }
    if (isValid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sucesso'),
          content: Text('Sua conta foi criada com sucesso'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey, thickness: 1),
                  const SizedBox(height: 16),
                  Text(
                    'Conectando você à Água, com comodidade e tecnologia\nCrie sua conta e seu lar não ficará mais à seca',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.blue.shade700),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        buildTextField('E-mail', 'Digite seu e-mail', controller: _emailController, error: _emailError, errorText: _emailErrorText),
                        const SizedBox(height: 12),
                        buildTextField('Senha', 'Digite sua senha', obscure: true, controller: _senhaController, error: _senhaError, errorText: _senhaErrorText),
                        const SizedBox(height: 12),
                        buildTextField('Confirme sua senha', 'Digite novamente sua senha', obscure: true, controller: _confirmaSenhaController, error: _confirmaSenhaError, errorText: _confirmaSenhaErrorText),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _criarConta,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: const Text(
                              'Criar',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Já possui uma conta? Acesse por aqui.',
                      style: TextStyle(fontSize: 13, color: Colors.blue),
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

  Widget buildTextField(String label, String hint, {bool obscure = false, TextEditingController? controller, bool error = false, String? errorText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.black87, fontSize: 14)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            errorText: error ? errorText : null,
          ),
        ),
      ],
    );
  }
}


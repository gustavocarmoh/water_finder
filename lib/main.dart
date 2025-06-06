import 'package:flutter/material.dart';
import 'signup_page.dart' hide ForgotPasswordPage;
import 'forgot_password_page.dart';
import 'home_page.dart';

void main() => runApp(AguaJaApp());

class AguaJaApp extends StatelessWidget {
  const AguaJaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _showError = false;
  bool _emailError = false;
  bool _senhaError = false;

  void _login() {
    setState(() {
      _showError = false;
      _emailError = false;
      _senhaError = false;
      if (_emailController.text == 'teste' && _senhaController.text == 'teste') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        _showError = true;
        _emailError = _emailController.text != 'teste';
        _senhaError = _senhaController.text != 'teste';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 250,
                  ),
                ),
                const SizedBox(height: 16),
                Divider(color: Colors.grey.shade300, thickness: 1),
                const SizedBox(height: 16),
                Text(
                  'Água inteligente, consumo consciente!',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                if (_showError)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Usuário e/ou senha incorretos',
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      buildTextField('E-mail', 'Digite aqui seu e-mail', controller: _emailController, error: _emailError),
                      const SizedBox(height: 12),
                      buildTextField('Senha', 'Digite aqui sua senha', obscure: true, controller: _senhaController, error: _senhaError),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(fontSize: 12, color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            'Acessar',
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
                        builder: (context) => SignupPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Não possui uma conta? Cadastre-se aqui!',
                    style: TextStyle(color: Colors.blue, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint, {bool obscure = false, TextEditingController? controller, bool error = false}) {
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
            errorText: error ? 'Campo incorreto' : null,
          ),
        ),
      ],
    );
  }
}

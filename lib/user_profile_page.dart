import 'package:flutter/material.dart';

import 'distributors_page.dart';
import 'home_page.dart';
import 'lista_agendamentos_page.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController _contatoController = TextEditingController(text: '+55 11998679953');
  final TextEditingController _emailController = TextEditingController(text: 'usuario@email.com');
  final TextEditingController _cepController = TextEditingController(text: '06542-010');
  final TextEditingController _cidadeController = TextEditingController(text: 'Santana de Parnaíba');
  final TextEditingController _enderecoController = TextEditingController(text: 'Alameda França');
  final TextEditingController _numeroController = TextEditingController(text: '1209');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildForm(context)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade100,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          const Text(
            'Perfil do Usuário',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 12),
          CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage('assets/profile_placeholder.png'),
          ),
          const SizedBox(height: 6),
          const Text(
            'Usuário',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        children: [
          _buildTextField('Contato', _contatoController),
          const SizedBox(height: 8),
          _buildTextField('E-mail', _emailController),
          const SizedBox(height: 8),
          _buildTextField('CEP', _cepController),
          const SizedBox(height: 8),
          _buildTextField('Cidade', _cidadeController),
          const SizedBox(height: 8),
          _buildTextField('Endereço', _enderecoController),
          const SizedBox(height: 8),
          _buildTextField('Número', _numeroController),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dados salvos com sucesso!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Salvar', style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.lightBlue.shade100,
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, size: 28),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                  (route) => false,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.location_on, size: 28),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const ListaAgendamentosPage()),
                  (route) => false,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_month, size: 28),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const DistributorsPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.black87, fontSize: 13)),
        const SizedBox(height: 4),
        SizedBox(
          height: 38,
          child: TextField(
            controller: controller,
            style: TextStyle(fontSize: 13),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
          ),
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:water_finder/user_profile_page.dart';
import 'distributors_page.dart';
import 'lista_agendamentos_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _buildTipsSection()),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context), // CORRIGIDO
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade100,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserProfilePage()),
              );
            },
            child: const CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage('assets/profile_placeholder.png'),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Usuário',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsSection() {
    final tips = [
      {
        'title': 'Chuveiros',
        'desc': 'Instale chuveiros com restritores de vazão para evitar desperdício',
      },
      {
        'title': 'Captação',
        'desc': 'Captar água da chuva é um ótimo método para economizar água',
      },
      {
        'title': 'Privadas',
        'desc': 'Instale descargas de dois botões (meia carga ou carga total)',
      },
      {
        'title': 'Vazamentos',
        'desc': 'Verifique vazamentos regularmente - goteiras imperceptíveis podem desperdiçar centenas de litros por mês',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Olá, Usuário!\nAqui vão dicas para economizar água',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          const SizedBox(height: 20),
          ...tips.map((tip) => _buildTipCard(tip['title']!, tip['desc']!)).toList(),
        ],
      ),
    );
  }

  Widget _buildTipCard(String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple),
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            style: const TextStyle(fontSize: 13),
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
                // já está na Home
              },
            ),
            IconButton(
              icon: const Icon(Icons.location_on, size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ListaAgendamentosPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_month, size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DistributorsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

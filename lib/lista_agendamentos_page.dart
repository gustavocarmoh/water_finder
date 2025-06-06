import 'package:flutter/material.dart';
import 'agendamento_model.dart';
import 'distributors_page.dart';
import 'home_page.dart';
import 'maps_page.dart';
import 'user_profile_page.dart';
import 'package:intl/intl.dart';

class ListaAgendamentosPage extends StatefulWidget {
  const ListaAgendamentosPage({super.key});

  @override
  State<ListaAgendamentosPage> createState() => _ListaAgendamentosPageState();
}

class _ListaAgendamentosPageState extends State<ListaAgendamentosPage> {
  @override
  Widget build(BuildContext context) {
    final agendamentos = AgendamentoRepository.agendamentos;
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Container(
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
                    child: CircleAvatar(
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
            ),
          ),
          Expanded(
            child: agendamentos.isEmpty
                ? const Center(child: Text('Nenhum agendamento salvo.'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 8, bottom: 4),
                        child: Text(
                          'Agendamentos em aberto',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return ListView.builder(
                              padding: const EdgeInsets.only(top: 0),
                              itemCount: agendamentos.length,
                              itemBuilder: (context, index) {
                                final ag = agendamentos[index];
                                final dataFormatada = DateFormat('dd/MM/yyyy').format(ag.data);
                                final horaFormatada = DateFormat('HH:mm').format(ag.data);
                                return Card(
                                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  elevation: 3,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                                    constraints: BoxConstraints(minHeight: 80),
                                    child: ListTile(
                                      leading: const Icon(Icons.location_on, color: Colors.blue, size: 32),
                                      title: Text(
                                        ag.nomeDistribuidor,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Data: $dataFormatada', style: const TextStyle(fontSize: 17)),
                                          Text('Hora: $horaFormatada', style: const TextStyle(fontSize: 17)),
                                        ],
                                      ),
                                      isThreeLine: false,
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        tooltip: 'Desmarcar',
                                        onPressed: () {
                                          setState(() {
                                            AgendamentoRepository.remover(index);
                                          });
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Agendamento removido!')),
                                          );
                                        },
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => MapaRotaPage(destino: ag.local),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }
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

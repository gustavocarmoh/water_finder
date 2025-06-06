import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'agendamento_model.dart';
import 'home_page.dart';
import 'lista_agendamentos_page.dart';
import 'user_profile_page.dart';

class DistributorsPage extends StatelessWidget {
  const DistributorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _buildDistributorsList(context)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
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

  Widget _buildDistributorsList(BuildContext context) {
    final List<Map<String, dynamic>> distributors = [
      {
        'name': 'Água Parnaíba',
        'address': 'Rua Alberto Frezda, 90',
        'latlng': LatLng(-23.441556, -46.917806),
      },
      {
        'name': 'BS Distribuidora',
        'address': 'Estrada Tenente Marques, 3355',
        'latlng': LatLng(-23.444444, -46.912345),
      },
      {
        'name': 'Distribuidora Água Pura',
        'address': 'Rua das Flores, 123 - Centro',
        'latlng': LatLng(-23.550520, -46.633308),
      },
      {
        'name': 'H2O Distribuição',
        'address': 'Av. Brasil, 456 - Jardim América',
        'latlng': LatLng(-23.561414, -46.655881),
      },
      {
        'name': 'Água Cristalina',
        'address': 'Rua do Sol, 789 - Vila Nova',
        'latlng': LatLng(-23.567890, -46.678901),
      },
      {
        'name': 'Fonte da Vida',
        'address': 'Av. Paulista, 1000 - Bela Vista',
        'latlng': LatLng(-23.564224, -46.652908),
      },
      {
        'name': 'Água Mineral Serra Azul',
        'address': 'Rua das Palmeiras, 321 - Morumbi',
        'latlng': LatLng(-23.601234, -46.712345),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16), // Espaço entre o menu superior e o texto
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 8, bottom: 8),
          child: Text(
            'Lista de distribuidores disponíveis',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: distributors.length,
            itemBuilder: (context, index) {
              final dist = distributors[index];
              return GestureDetector(
                onTap: () => _showScheduleDialog(context, dist['name'], dist['latlng']),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  constraints: BoxConstraints(minHeight: 90),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dist['name'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            const SizedBox(height: 4),
                            Text('Endereço: ${dist['address']}', style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.schedule, size: 32, color: Colors.grey.shade700),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _showScheduleDialog(BuildContext context, String nomeDistribuidor, LatLng destino) async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    await showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              titlePadding: const EdgeInsets.all(16),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              title: Row(
                children: [
                  const Icon(Icons.calendar_month, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Agendar com:',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    nomeDistribuidor,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Divider(color: Colors.grey.shade300),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                      );
                      if (date != null) setState(() => selectedDate = date);
                    },
                    icon: const Icon(Icons.date_range),
                    label: Text(
                      selectedDate == null
                          ? 'Selecionar data'
                          : DateFormat('dd/MM/yyyy').format(selectedDate!),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) setState(() => selectedTime = time);
                    },
                    icon: const Icon(Icons.access_time),
                    label: Text(
                      selectedTime == null
                          ? 'Selecionar horário'
                          : selectedTime!.format(context),
                    ),
                  ),
                ],
              ),
              actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: selectedDate != null && selectedTime != null
                      ? () {
                          // Monta a data/hora correta
                          final dataAgendamento = DateTime(
                            selectedDate!.year,
                            selectedDate!.month,
                            selectedDate!.day,
                            selectedTime!.hour,
                            selectedTime!.minute,
                          );
                          // Salva o agendamento com nome do distribuidor, data/hora e local
                          AgendamentoRepository.adicionar(
                            Agendamento(
                              'Agendamento salvo',
                              dataAgendamento,
                              destino,
                              nomeDistribuidor,
                            ),
                          );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Agendado para ${DateFormat('dd/MM/yyyy').format(dataAgendamento)} às ${DateFormat('HH:mm').format(dataAgendamento)}'),
                            backgroundColor: Colors.green.shade600,
                          ));
                        }
                      : null,
                  child: const Text('Agendar'),
                ),
              ],
            );
          },
        );
      },
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
                // já está na tela de distribuidores
              },
            ),
          ],
        ),
      ),
    );
  }
}

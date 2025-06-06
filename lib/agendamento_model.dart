import 'package:latlong2/latlong.dart';

class Agendamento {
  final String titulo;
  final DateTime data;
  final LatLng local;
  final String nomeDistribuidor;

  Agendamento(this.titulo, this.data, this.local, this.nomeDistribuidor);
}

class AgendamentoRepository {
  static final List<Agendamento> _agendamentos = [];

  static List<Agendamento> get agendamentos => _agendamentos;

  static void adicionar(Agendamento agendamento) {
    _agendamentos.add(agendamento);
  }

  static void remover(int index) {
    _agendamentos.removeAt(index);
  }
}


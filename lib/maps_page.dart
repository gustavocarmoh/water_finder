import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'agendamento_model.dart';
import 'distributors_page.dart';
import 'home_page.dart';
import 'lista_agendamentos_page.dart';

class MapaRotaPage extends StatefulWidget {
  final LatLng? destino;

  const MapaRotaPage({super.key, this.destino});

  @override
  State<MapaRotaPage> createState() => _MapaRotaPageState();
}

class _MapaRotaPageState extends State<MapaRotaPage> {
  LatLng? _center;
  bool _loading = true;
  List<LatLng> _rota = [];
  Agendamento? _agendamentoSelecionado;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    if (widget.destino != null) {
      setState(() {
        _center = widget.destino;
        _loading = false;
      });
    } else {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (serviceEnabled && (permission == LocationPermission.always || permission == LocationPermission.whileInUse)) {
        Position pos = await Geolocator.getCurrentPosition();
        setState(() {
          _center = LatLng(pos.latitude, pos.longitude);
          _loading = false;
        });
      } else {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  void _iniciarRota(Agendamento agendamento) async {
    final pos = await Geolocator.getCurrentPosition();
    setState(() {
      _rota = [LatLng(pos.latitude, pos.longitude), agendamento.local];
      _agendamentoSelecionado = agendamento;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rota para o distribuidor')),
      body: _loading || _center == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (AgendamentoRepository.agendamentos.isNotEmpty)
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: AgendamentoRepository.agendamentos.length,
                      itemBuilder: (context, index) {
                        final ag = AgendamentoRepository.agendamentos[index];
                        final selecionado = _agendamentoSelecionado == ag;
                        return Card(
                          margin: const EdgeInsets.all(8),
                          color: selecionado ? Colors.blue.shade100 : null,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _agendamentoSelecionado = ag;
                                _rota = [];
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(ag.titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text('${ag.data.day}/${ag.data.month}/${ag.data.year}'),
                                  if (selecionado)
                                    const Icon(Icons.check_circle, color: Colors.blue),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                Expanded(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: _center!,
                      initialZoom: 16,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _center!,
                            width: 40,
                            height: 40,
                            child: const Icon(Icons.location_on, size: 40, color: Colors.red),
                          ),
                          if (_agendamentoSelecionado != null)
                            Marker(
                              point: _agendamentoSelecionado!.local,
                              width: 40,
                              height: 40,
                              child: const Icon(Icons.flag, size: 40, color: Colors.blue),
                            ),
                        ],
                      ),
                      if (_rota.isNotEmpty)
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: _rota,
                              color: Colors.blue,
                              strokeWidth: 4,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            icon: const Icon(Icons.directions),
            label: const Text('Iniciar rota'),
            onPressed: () async {
              Future<Position?> getCurrentPositionWithPermission() async {
                LocationPermission permission = await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();
                  if (permission == LocationPermission.denied) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Permissão de localização negada. Por favor, permita o acesso à localização.')),
                    );
                    return null;
                  }
                }
                if (permission == LocationPermission.deniedForever) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Permissão de localização permanentemente negada. Vá nas configurações do dispositivo para permitir.')),
                  );
                  return null;
                }
                return await Geolocator.getCurrentPosition();
              }
              // Se já existe uma rota desenhada, apenas redesenha a partir da localização atual
              Position? pos;
              if (_rota.isNotEmpty) {
                pos = await getCurrentPositionWithPermission();
                if (pos != null) {
                  setState(() {
                    _rota = [LatLng(pos!.latitude, pos!.longitude), _rota.last];
                  });
                }
              } else if (_agendamentoSelecionado != null) {
                pos = await getCurrentPositionWithPermission();
                if (pos != null) {
                  setState(() {
                    _rota = [LatLng(pos!.latitude, pos!.longitude), _agendamentoSelecionado!.local];
                  });
                }
              } else {
                // Se não há rota nem agendamento, mas já está no mapa, traça uma rota para o centro
                if (_center != null) {
                  pos = await getCurrentPositionWithPermission();
                  if (pos != null) {
                    setState(() {
                      _rota = [LatLng(pos!.latitude, pos!.longitude), _center!];
                    });
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Não foi possível iniciar a rota.')),
                  );
                }
              }
            },
          ),
          const SizedBox(height: 12),
          // FloatingActionButton.extended(
          //   icon: const Icon(Icons.save),
          //   label: const Text('Salvar agendamento'),
          //   onPressed: () async {
          //     String nomeDistribuidor = 'Personalizado';
          //     // Tenta herdar o nome do distribuidor se vier da tela de distribuidores
          //     if (widget.destino != null) {
          //       // Aqui você pode buscar o nome do distribuidor pelo LatLng se desejar
          //       // Exemplo simples: se o usuário veio da tela de distribuidores, passe o nome via arguments
          //       if (ModalRoute.of(context)?.settings.arguments is String) {
          //         nomeDistribuidor = ModalRoute.of(context)!.settings.arguments as String;
          //       } else {
          //         nomeDistribuidor = 'Distribuidor';
          //       }
          //     }
          //     if (_rota.length == 2) {
          //       final destino = _rota[1];
          //       final agendamento = Agendamento(
          //         'Agendamento salvo',
          //         DateTime.now(),
          //         destino,
          //         nomeDistribuidor,
          //       );
          //       AgendamentoRepository.adicionar(agendamento);
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('Agendamento salvo com sucesso!')),
          //       );
          //       setState(() {
          //         _agendamentoSelecionado = agendamento;
          //       });
          //       Future.delayed(const Duration(milliseconds: 500), () {
          //         Navigator.of(context).pop();
          //       });
          //     } else if (widget.destino != null) {
          //       final agendamento = Agendamento(
          //         'Agendamento salvo',
          //         DateTime.now(),
          //         widget.destino!,
          //         nomeDistribuidor,
          //       );
          //       AgendamentoRepository.adicionar(agendamento);
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('Agendamento salvo com sucesso!')),
          //       );
          //       setState(() {
          //         _agendamentoSelecionado = agendamento;
          //       });
          //       Future.delayed(const Duration(milliseconds: 500), () {
          //         Navigator.of(context).pop();
          //       });
          //     } else {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('Crie uma rota antes de salvar o agendamento.')),
          //       );
          //     }
          //   },
          // ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ListaAgendamentosPage()),
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
}

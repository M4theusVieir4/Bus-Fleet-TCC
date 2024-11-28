import 'dart:async';

import 'package:busbr/domain/entities/onibus/onibus.dart';
import 'package:busbr/domain/entities/onibus/ponto.dart';
import 'package:busbr/infra/core/routes/bus_br_routes.dart';
import 'package:busbr/modules/bus_tracker/route_bus/cubit/route_bus_controller.dart';
import 'package:busbr/modules/bus_tracker/route_bus/cubit/route_bus_state.dart';
import 'package:busbr/modules/bus_tracker/select_bus/cubit/select_bus_controller.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteBusPage extends StatefulWidget {
  const RouteBusPage({super.key});

  @override
  State<RouteBusPage> createState() => MapSampleState();
}

class MapSampleState extends State<RouteBusPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late RouteBusController _cubit;
  late Onibus _onibus;

  // Posições fixas
  LatLng _busLocation = LatLng(-23.59301, -46.90184); // Localização do ônibus
  static const LatLng _userLocation =
      LatLng(-23.60212425120302, -46.639937315130155); // Sua localização
  static LatLng? _destinationLocation;
  static LatLng? _origemLocation;
  late Ponto pontoDestino;
  late Ponto pontoInicial;
  late Timer _timer;
  int _catraca = 0;

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(-23.60212425120302, -46.639937315130155),
    zoom: 20.0,
  );
  Set<Polyline> _polylines = {};

  BitmapDescriptor? busIcon;
  BitmapDescriptor? userIcon;
  BitmapDescriptor? destinationIcon;

  @override
  void initState() {
    _cubit = Modular.get()..initialize();
    _onibus = Modular.get<SelectBusController>().state.onibus!;
    super.initState();
    _startLocationUpdates();
    _loadIcons();
    _initializeDestinationCoordinates().then((_) {
      _loadRoute();
    });
  }

  void _startLocationUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _cubit.getBusLocation(idEquipamento: _onibus.idEquipamento);
    });
  }

  Future<void> _loadRoute() async {
    try {
      List<LatLng> route =
          await getRoute(_origemLocation!, _destinationLocation!);
      setState(() {
        _polylines.add(Polyline(
          polylineId: PolylineId('route'),
          points: route,
          color: Color(0xFFED5D1F),
          width: 5,
        ));
      });

      _moveCameraToRoute(route);
    } catch (e) {
      print('Erro ao carregar a rota: $e');
    }
  }

  Future<void> _moveCameraToRoute(List<LatLng> route) async {
    final GoogleMapController controller = await _controller.future;
    final bounds = LatLngBounds(
      southwest: LatLng(
        route.map((point) => point.latitude).reduce((a, b) => a < b ? a : b),
        route.map((point) => point.longitude).reduce((a, b) => a < b ? a : b),
      ),
      northeast: LatLng(
        route.map((point) => point.latitude).reduce((a, b) => a > b ? a : b),
        route.map((point) => point.longitude).reduce((a, b) => a > b ? a : b),
      ),
    );
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  Future<void> _initializeDestinationCoordinates() async {
    pontoInicial = _onibus.onibusRotas[0].rota.rotasPontos
        .reduce((a, b) => a.ordem < b.ordem ? a : b)
        .ponto;

    pontoDestino = _onibus.onibusRotas[0].rota.rotasPontos
        .reduce((a, b) => a.ordem > b.ordem ? a : b)
        .ponto;
    var destination = await getCoordinatesFromAddress(pontoDestino.ruaAvenida);
    var destinationOrigem =
        await getCoordinatesFromAddress(pontoInicial.ruaAvenida);
    if (destination != null) {
      setState(() {
        _destinationLocation = destination;
        _origemLocation = destinationOrigem;
      });
    }
  }

  Future<List<LatLng>> getRoute(LatLng origin, LatLng destination) async {
    const String apiKey = 'AIzaSyAJFzDLmQgIuoEQ4gf6_LbRSPgtuQLSH_o';
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        List<LatLng> routeCoordinates = [];
        for (var step in data['routes'][0]['legs'][0]['steps']) {
          final polyline = step['polyline']['points'];
          routeCoordinates.addAll(decodePolyline(polyline));
        }
        return routeCoordinates;
      } else {
        throw Exception('Erro ao obter a rota: ${data['status']}');
      }
    } else {
      throw Exception('Erro ao acessar a API');
    }
  }

// Função para decodificar a polyline retornada pela API
  List<LatLng> decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0;
    int len = polyline.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b = 0;
      int shift = 0;
      int result = 0;
      do {
        b = polyline.codeUnitAt(index) - 63;
        index++;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index) - 63;
        index++;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  @override
  void dispose() {
    _timer.cancel();
    _cubit.close();
    super.dispose();
  }

  Future<void> _loadIcons() async {
    busIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)), AppIcons.busIconPNG);
    userIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)), AppIcons.pointIconPNG);
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)), AppIcons.aimFillPNG);

    setState(() {});
  }

  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        double latitude = locations.first.latitude;
        double longitude = locations.first.longitude;
        print("Latitude: $latitude, Longitude: $longitude");
        LatLng destination = LatLng(latitude, longitude);
        return destination;
      } else {
        print("Endereço não encontrado.");
      }
    } catch (e) {
      print("Erro ao obter coordenadas: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final design = DesignSystem.of(context);

    return Scaffold(
        body: BlocConsumer<RouteBusController, RouteBusState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is RouteBusSuccessState) {
          setState(() {
            _busLocation = LatLng(
              state.equipamento!.comunicacaos[0].latitude,
              state.equipamento!.comunicacaos[0].longitude,
            );

            _catraca = state.equipamento!.catraca.quantidadeEntrada;
          });
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              compassEnabled: false,
              mapToolbarEnabled: false,
              markers: {
                Marker(
                  markerId: MarkerId('bus'),
                  position: _busLocation,
                  icon: busIcon ?? BitmapDescriptor.defaultMarker,
                ),
                Marker(
                  markerId: const MarkerId('user'),
                  position: _userLocation,
                  icon: userIcon ?? BitmapDescriptor.defaultMarker,
                ),
                Marker(
                  markerId: const MarkerId('destination'),
                  position: _destinationLocation ?? const LatLng(0.0, 0.0),
                  icon: destinationIcon ?? BitmapDescriptor.defaultMarker,
                ),
              },
              polylines: _polylines,
            ),
            // Botões flutuantes na parte superior esquerda
            Positioned(
              top: 35,
              left: 16,
              child: FloatingActionButton(
                backgroundColor: design.neutral900,
                heroTag: "btn1",
                onPressed: () {
                  Modular.to.pushNamed(BusBrRoutes.SELECT_BUS);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: design.neutral,
                  size: 24.0,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: design.secondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  border: Border(
                    top: BorderSide(
                      color: design.primary,
                      width: 5.0,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        color: design.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'A caminho',
                          style: design.h4(color: design.primary),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 30),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: design.primary,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(40, 80)),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppIcons.clockPNG,
                                    width: 24,
                                    height: 24,
                                    color: design.tertiary100,
                                  ),
                                  Text(
                                    '10 Min',
                                    style: design.paragraphS(
                                        color: design.neutral900),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                'Ônibus',
                                style:
                                    design.overline(color: design.neutral300),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                _onibus.onibusRotas[0].rota.nomeRota,
                                style: design.paragraphDMedium(
                                    color: design.primary),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            _showFeedbackForm(context);
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 30),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: design.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.chat,
                                  color: design.tertiary100,
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(right: 30),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: design.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: design.tertiary100,
                                      ),
                                      Text(
                                        '${_catraca}',
                                        style: design.paragraphS(
                                            color: design.neutral900),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: CustomPaint(
                        painter: DottedBorderPainter(
                          paintLeft: true,
                          paintBottom: true,
                          iconGapStart: 0,
                          iconGapEnd: 34,
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Ponto 0",
                                              style: design.overline(
                                                  color: design.neutral200),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              pontoInicial.ruaAvenida
                                                  .split('-')[0],
                                              style: design.paragraphM(
                                                  color: design.primary),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            Positioned(
                              left: -12,
                              top: 10,
                              child: Image.asset(
                                AppIcons.busIconPNG,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: CustomPaint(
                        painter: DottedBorderPainter(
                          paintLeft: true,
                          paintBottom: false,
                          iconGapStart: 8,
                          iconGapEnd: 34,
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                left: 5,
                                                top: 10,
                                              ),
                                              child: Text(
                                                "Seu Local",
                                                style: design.overline(
                                                    color: design.neutral200),
                                              )),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 5,
                                            ),
                                            child: Text(
                                              'R. Primeiro de Janeiro',
                                              style: design.paragraphM(
                                                  color: design.primary),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            Positioned(
                              left: -12,
                              top: 10,
                              child: Image.asset(
                                AppIcons.pointIconPNG,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 15,
                      ),
                      child: CustomPaint(
                        painter: DottedBorderPainter(
                            paintLeft: true,
                            paintBottom: true,
                            iconGapStart: 8,
                            iconGapEnd: 34),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 5,
                                            ),
                                            child: Text(
                                              "Destino",
                                              style: design.overline(
                                                  color: design.neutral200),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 5,
                                            ),
                                            child: Text(
                                              pontoDestino.ruaAvenida
                                                  .split('-')[0],
                                              style: design.paragraphM(
                                                  color: design.primary),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            Positioned(
                              left:
                                  -12, // Ajuste para metade do ícone sair pela borda esquerda
                              top: 10, // Alinhamento vertical do ícone
                              child: Image.asset(
                                AppIcons.aimFillPNG,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ));
  }

  void _showFeedbackForm(BuildContext context) {
    final design = DesignSystem.of(context);
    showModalBottomSheet(
      backgroundColor: design.secondary,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Envie seu Feedback',
                style: design.h4(color: design.primary),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Escreva aqui...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 7,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Adicione a ação para enviar o feedback
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: design.primary,
                ),
                child: Text(
                  'Enviar',
                  style: design.paragraphS(color: design.neutral900),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final bool paintLeft;
  final bool paintBottom;
  final double iconGapStart; // Início da lacuna para o ícone
  final double iconGapEnd; // Fim da lacuna para o ícone

  DottedBorderPainter({
    this.paintLeft = true,
    this.paintBottom = true,
    this.iconGapStart = 0,
    this.iconGapEnd = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black // Cor da borda
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5; // Largura da linha

    double dashWidth = 5; // Comprimento do traço
    double dashSpace = 3; // Espaçamento entre traços

    if (paintLeft) {
      // Desenha a borda esquerda, com uma lacuna para o ícone
      double startY = 0;
      while (startY < size.height) {
        if (startY < iconGapStart || startY > iconGapEnd) {
          canvas.drawLine(
            Offset(0, startY),
            Offset(0, startY + dashWidth),
            paint,
          );
        }
        startY += dashWidth + dashSpace;
      }
    }

    if (paintBottom) {
      // Desenha a borda inferior sem interrupções
      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, size.height),
          Offset(startX + dashWidth, size.height),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

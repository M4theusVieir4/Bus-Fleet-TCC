import 'dart:async';

import 'package:busbr/infra/core/routes/bus_br_routes.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteBusPage extends StatefulWidget {
  const RouteBusPage({super.key});

  @override
  State<RouteBusPage> createState() => MapSampleState();
}

class MapSampleState extends State<RouteBusPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // Posições fixas
  static const LatLng _busLocation =
      LatLng(-23.59301, -46.90184); // Localização do ônibus
  static const LatLng _userLocation =
      LatLng(-23.59310, -46.90200); // Sua localização
  static const LatLng _destinationLocation =
      LatLng(-23.59450, -46.90250); // Destino

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(-23.59301, -46.90184),
    zoom: 20.0,
  );

  BitmapDescriptor? busIcon;
  BitmapDescriptor? userIcon;
  BitmapDescriptor? destinationIcon;

  @override
  void initState() {
    super.initState();
    _loadIcons();
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final design = DesignSystem.of(context);
    return Scaffold(
      body: Stack(
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
                position: _destinationLocation,
                icon: destinationIcon ?? BitmapDescriptor.defaultMarker,
              ),
            },
            polylines: {
              Polyline(
                polylineId: const PolylineId('route'),
                points: [_busLocation, _destinationLocation],
                color: design.tertiary100,
                width: 5,
              ),
            },
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
                              style:
                                  design.paragraphS(color: design.neutral900),
                            ),
                          ],
                        ),
                      ),
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
                              style: design.overline(color: design.neutral300),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Linha 468",
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
                        child: Container(
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
                        clipBehavior: Clip
                            .none, // Permite que os widgets saiam do limite do Stack
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left:
                                    16), // Espaço para o ícone na borda esquerda
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
                                            'Siasson Av.',
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
                                -12, // Ajusta o ícone para que ele fique metade para fora da borda esquerda
                            top:
                                10, // Ajuste a altura do ícone conforme necessário
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
                        clipBehavior: Clip
                            .none, // Permite que os widgets saiam do limite do Stack
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
                                            'West New Brighton',
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
                                -12, // Metade do tamanho do ícone para que ele fique 50% fora e 50% dentro do contêiner
                            top:
                                10, // Ajusta a altura do ícone em relação ao conteúdo
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
                                            'Enderson Ava',
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
      ),
    );
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

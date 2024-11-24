import 'dart:async';

import 'package:busbr/infra/core/routes/bus_br_routes.dart';
import 'package:busbr/infra/core/validators/validators.dart';
import 'package:busbr/modules/home/cubit/home_controller.dart';
import 'package:busbr/modules/home/cubit/home_state.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  final Function navigateToNotification;
  final Function navigateToConfiguration;

  const HomePage({
    super.key,
    required this.navigateToNotification,
    required this.navigateToConfiguration,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-23.60212425120302, -46.639937315130155),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-23.60212425120302, -46.639937315130155),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  BitmapDescriptor? locationMap;

  late HomeController _cubit;

  //Formulários
  late TextEditingController _enderecoOrigemController;
  late TextEditingController _enderecoDestinoController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _cubit = Modular.get()..initialize();
    _enderecoOrigemController = TextEditingController();
    _enderecoDestinoController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    BitmapDescriptor.asset(
            ImageConfiguration(size: Size(100, 100)), AppIcons.locationMap)
        .then((onValue) {
      locationMap = onValue;
    });
    super.initState();
  }

  @override
  void dispose() {
    _enderecoOrigemController.dispose();
    _enderecoDestinoController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _onPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      _cubit.buscarRota(
        enderecoOrigem: _enderecoOrigemController.text,
        enderecoDestino: _enderecoDestinoController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Scaffold(
      body: BlocConsumer<HomeController, HomeState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is HomeSuccessState) {
            Modular.to.pushNamed(BusBrRoutes.SELECT_BUS);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                compassEnabled: false,
                mapToolbarEnabled: false,
                markers: {
                  Marker(
                    markerId: MarkerId('teste'),
                    position: LatLng(-23.60212425120302, -46.639937315130155),
                    icon: locationMap ?? BitmapDescriptor.defaultMarker,
                  )
                },
                circles: {
                  Circle(
                    circleId: CircleId('teste'),
                    center: LatLng(-23.60212425120302, -46.639937315130155),
                    radius: 400,
                    fillColor: design.tertiary100.withOpacity(0.1),
                    strokeWidth: 2,
                    strokeColor: design.tertiary100,
                  ),
                },
              ),
              // Botões flutuantes na parte superior esquerda
              Positioned(
                top: 16,
                left: 16,
                child: Row(
                  children: [
                    FloatingActionButton(
                      backgroundColor: design.primary,
                      heroTag: "btn1",
                      onPressed: () {
                        widget.navigateToConfiguration();
                      },
                      child: Image.asset(
                        AppIcons.menu,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    SizedBox(width: 20),
                    FloatingActionButton(
                      backgroundColor: design.primary,
                      heroTag: "btn2",
                      onPressed: () {
                        widget.navigateToNotification();
                      },
                      child: Image.asset(
                        AppIcons.bell,
                        height: 22,
                        width: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: TextButton(
        onPressed: () {
          _showForm(design, context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Fundo branco para o botão
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
          padding: EdgeInsets.all(0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: design.tertiary100, // Fundo laranja para o ícone
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  AppIcons.aimPNG,
                  width: 24,
                  height: 24,
                ),
              ),
              SizedBox(width: 8), // Espaçamento entre o ícone e o texto
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Para Onde iremos agora?',
                  style: design.paragraphD(color: design.tertiary100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showForm(AppDesign design, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Para permitir bordas arredondadas
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Card(
            margin: EdgeInsets.zero,
            color: design.secondary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              side: BorderSide.none, // Remove a borda padrão
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: design.tertiary100,
                    width: 5.0,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 5,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      color: design.tertiary100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, bottom: 24.0, top: 10),
                    child: SingleChildScrollView(
                      child: _searchAddress(design, context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Form _searchAddress(AppDesign design, BuildContext context) {
    // final GoogleMapController controller = await _controller.future;
    // await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            'Para onde iremos agora?',
            style: design.h6(color: design.primary),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Por favor realize o login com suas informações',
            style: design.overline(color: design.primary),
          ),
          const SizedBox(
            height: 20,
          ),
          ADPTextFormField(
            fillColor: design.neutral600,
            context,
            controller: _enderecoOrigemController,
            prefixIcon: Container(
              margin: EdgeInsets.only(right: 30),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: design.primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    topLeft: Radius.circular(8)),
              ),
              child: Image.asset(AppIcons.locationPNG),
            ),
            label: 'Insira o local de partida',
            validators: Validators.required('campo obrigatório'),
          ),
          SizedBox(
            height: 16.height,
          ),
          Visibility(
            child: ADPTextFormField(
              fillColor: design.neutral600,
              context,
              controller: _enderecoDestinoController,
              prefixIcon: Container(
                margin: EdgeInsets.only(right: 30),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: design.primary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                ),
                child: Image.asset(AppIcons.aimPNG),
              ),
              label: 'Para onde?',
              formFieldType: TextInputType.text,
              validators: Validators.required('campo obrigatório'),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ADPDefaultButton(
            label: 'Buscar',
            primaryColor: design.tertiary100,
            labelColor: design.neutral900,
            colorLoading: design.neutral900,
            enablePressOnLoading: false,
            onPressed: _onPressed,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

import 'package:busbr/infra/core/routes/bus_br_routes.dart';
import 'package:busbr/infra/core/validators/validators.dart';
import 'package:busbr/modules/auth/login/cubit/login_controller.dart';
import 'package:busbr/modules/auth/login/cubit/login_state.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SelectBusPage extends StatefulWidget {
  const SelectBusPage({super.key});

  @override
  State<SelectBusPage> createState() => _SelectBusPageState();
}

class _SelectBusPageState extends State<SelectBusPage> {
  late Color myColor;
  late Size mediaSize;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKey;
  late LoginController _cubit;
  bool _isObscurePassword = true;
  bool rememberUser = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _cubit = Modular.get()..initialize();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _onPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      _cubit.login(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.4,
            child: Container(
              decoration: BoxDecoration(
                color: design.primary,
                image: DecorationImage(
                  image: const AssetImage(AppIcons.backgroundSelectPNG),
                  fit: BoxFit.none,
                  colorFilter: ColorFilter.mode(
                      design.primary.withOpacity(1), BlendMode.lighten),
                ),
              ),
            ),
          ),
          Positioned(
            top: 35,
            left: 16,
            child: FloatingActionButton(
              backgroundColor: design.neutral900,
              heroTag: "btn1",
              onPressed: () {
                Modular.to.pushNamed(BusBrRoutes.HOME);
              },
              child: Icon(
                Icons.arrow_back,
                color: design.neutral,
                size: 24.0,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.3,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView.separated(
              itemCount: 4,
              padding: EdgeInsets.only(top: 16),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(color: Colors.transparent),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed(BusBrRoutes.ROUTE_BUS);
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: design.tertiary100,
                                height: 100,
                                child: Center(
                                  child: Text(
                                    '$index',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                color: design.neutral900,
                                height: 100,
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Linha 468',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: const [
                                        Text(
                                          'De: ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Terminal Cotia',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: const [
                                        Text(
                                          'Para: ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Res. das Estrelas',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: design.primary,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Preço:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '8 \$',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Expanded(
                                          child: Text(
                                            '17h, Quarta',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Expanded(
                                          child: Text(
                                            '23/10/2024',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

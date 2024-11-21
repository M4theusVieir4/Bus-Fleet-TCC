import 'package:busbr/domain/entities/usuario/usuario_entity.dart';
import 'package:busbr/modules/auth/login/cubit/login_controller.dart';
import 'package:design_kit/configs/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  bool isModoDeficientes = false;
  bool isNotificacoes = false;
  late UsuarioEntity _user;

  @override
  void initState() {
    super.initState();
    _user = Modular.get<LoginController>().state.user!;
    isModoDeficientes = _user.preferencia!.deficiencia;
    isNotificacoes = _user.preferencia!.notificacao;
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: design.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  padding: EdgeInsets.only(left: 16, top: 40),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: design.neutral900,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Configurações',
                          style: design.h1(color: design.neutral900),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: design.neutral900,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: design.primary,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 24.0,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(_user.nome!,
                                style:
                                    design.paragraphM(color: design.neutral)),
                          ],
                        ),
                      ),
                      Divider(
                        color: design.neutral500,
                        thickness: 1.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text('Configurações de Conta',
                            style: design.h5(color: design.neutral400)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Modo para deficientes',
                              style: design.paragraphD(color: design.primary),
                            ),
                            Switch(
                              value: isModoDeficientes,
                              activeColor: design.primary,
                              inactiveThumbColor: design.neutral900,
                              inactiveTrackColor: design.neutral500,
                              onChanged: (bool newValue) {
                                setState(() {
                                  isModoDeficientes = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Notificações',
                              style: design.paragraphD(color: design.primary),
                            ),
                            Switch(
                              value: isNotificacoes,
                              activeColor: design.primary,
                              inactiveThumbColor: design.neutral900,
                              inactiveTrackColor: design.neutral500,
                              onChanged: (bool newValue) {
                                setState(() {
                                  isNotificacoes = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: design.neutral500,
                        thickness: 1.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text('Mais',
                            style: design.h5(color: design.neutral400)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sobre nós',
                              style: design.paragraphD(color: design.primary),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Política de Privacidade',
                              style: design.paragraphD(color: design.primary),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

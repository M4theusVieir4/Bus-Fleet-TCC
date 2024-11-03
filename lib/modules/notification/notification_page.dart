import 'package:busbr/infra/core/routes/bus_br_routes.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationEntity> readNotifications = [
    NotificationEntity(
      idNotificacao: 1,
      idNotificacaoTipo: 2,
      idRegistro: 101,
      mensagem: "Notificação lida 1",
      idEquipe: 10,
      idUsuario: 1001,
      flagRequerCiencia: true,
      dataCiencia: DateTime.now().subtract(Duration(days: 2)),
      idUsuarioCiencia: 1001,
      dataCriacao: DateTime.now().subtract(Duration(days: 3)),
      flagMensagem: true,
      fakeDelete: 0,
      lida: true,
      titulo: "Notificação Lida 1",
      subtitulo: "Subtítulo Lida 1",
    ),
    NotificationEntity(
      idNotificacao: 2,
      idNotificacaoTipo: 3,
      idRegistro: 102,
      mensagem: "Notificação lida 2",
      idEquipe: 11,
      idUsuario: 1002,
      flagRequerCiencia: false,
      dataCriacao: DateTime.now().subtract(Duration(days: 4)),
      flagMensagem: false,
      fakeDelete: 0,
      lida: true,
      titulo: "Notificação Lida 2",
      subtitulo: "Subtítulo Lida 2",
    ),
  ];

  List<NotificationEntity> unreadNotifications = [
    NotificationEntity(
      idNotificacao: 3,
      idNotificacaoTipo: 4,
      idRegistro: 103,
      mensagem: "Notificação não lida 1",
      idEquipe: 12,
      idUsuario: 1003,
      flagRequerCiencia: false,
      dataCriacao: DateTime.now().subtract(Duration(days: 1)),
      flagMensagem: true,
      fakeDelete: 0,
      lida: false,
      titulo: "Notificação Não Lida 1",
      subtitulo: "Subtítulo Não Lida 1",
    ),
    NotificationEntity(
      idNotificacao: 4,
      idNotificacaoTipo: 5,
      idRegistro: 104,
      mensagem: "Notificação não lida 2",
      idEquipe: 13,
      idUsuario: 1004,
      flagRequerCiencia: true,
      dataCriacao: DateTime.now(),
      flagMensagem: true,
      fakeDelete: 0,
      lida: false,
      titulo: "Notificação Não Lida 2",
      subtitulo: "Subtítulo Não Lida 2",
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Scaffold(
        backgroundColor: design.neutral900,
        appBar: AppBar(
          backgroundColor: design.primary,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Notificações',
            style: design.h1(color: design.neutral900),
          ),
        ),
        body: notifications(design));
  }

  Widget notifications(AppDesign design) {
    return ListView.separated(
      key: const Key('listView'),
      itemCount: 2 + unreadNotifications.length + readNotifications.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                Icon(
                  Icons.circle_sharp,
                  color: design.primary,
                  size: 14,
                ),
                SizedBox(width: 12.height),
                Text(
                  'Não lidas',
                  style: design.subtitleMedium(
                    color: design.neutral300,
                  ),
                ),
              ],
            ),
          );
        } else if (index <= unreadNotifications.length) {
          final unreadIndex = index - 1;
          return GestureDetector(
            onTap: !unreadNotifications[unreadIndex].lida
                ? () =>
                    {} //_clickInNotification(unreadNotifications[unreadIndex])
                : () {},
            child: Container(
              decoration: ShapeDecoration(
                color: unreadNotifications[unreadIndex].lida
                    ? design.neutral700
                    : design.primary,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: unreadNotifications[unreadIndex].lida
                        ? design.neutral700
                        : design.primary,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      unreadNotifications[unreadIndex].titulo ?? '',
                      style: design.labelMMedium(
                        color: unreadNotifications[unreadIndex].lida
                            ? design.neutral
                            : design.neutral900,
                      ),
                    ),
                    SizedBox(
                      height: 8.height,
                    ),
                    Text(
                      unreadNotifications[unreadIndex].mensagem ?? '',
                      style: design.labelS(
                        color: unreadNotifications[unreadIndex].lida
                            ? design.neutral
                            : design.neutral900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (index == unreadNotifications.length + 1) {
          return Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                Icon(
                  Icons.circle_sharp,
                  color: design.neutral500,
                  size: 14,
                ),
                SizedBox(width: 12.height),
                Text(
                  'Lidas',
                  style: design.subtitleMedium(
                    color: design.neutral300,
                  ),
                ),
              ],
            ),
          );
        } else {
          final readIndex = index - unreadNotifications.length - 2;
          return GestureDetector(
            onTap: !readNotifications[readIndex].lida
                ? () => {} //_clickInNotification(readNotifications[readIndex])
                : () {},
            child: Container(
              decoration: ShapeDecoration(
                color: readNotifications[readIndex].lida
                    ? design.neutral700
                    : design.primary,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: readNotifications[readIndex].lida
                        ? design.neutral700
                        : design.primary,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      readNotifications[readIndex].titulo ?? '',
                      style: design.labelMMedium(
                        color: readNotifications[readIndex].lida
                            ? design.neutral
                            : design.neutral900,
                      ),
                    ),
                    SizedBox(
                      height: 8.height,
                    ),
                    Text(
                      readNotifications[readIndex].mensagem ?? '',
                      style: design.labelS(
                        color: readNotifications[readIndex].lida
                            ? design.neutral
                            : design.neutral900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 24.height,
      ),
      padding: const EdgeInsets.only(
        top: 0,
        left: 24,
        right: 24,
        bottom: 16,
      ),
    );
  }
}

class NotificationEntity {
  final int idNotificacao;
  final int idNotificacaoTipo;
  final int idRegistro;
  final String? mensagem;
  final int? idEquipe;
  final int? idUsuario;
  final bool flagRequerCiencia;
  final DateTime? dataCiencia;
  final int? idUsuarioCiencia;
  final DateTime dataCriacao;
  final bool flagMensagem;
  final int fakeDelete;
  late bool lida;
  final String? titulo;
  final String? subtitulo;

  NotificationEntity({
    required this.idNotificacao,
    required this.idNotificacaoTipo,
    required this.idRegistro,
    this.mensagem,
    this.idEquipe,
    this.idUsuario,
    required this.flagRequerCiencia,
    this.dataCiencia,
    this.idUsuarioCiencia,
    required this.dataCriacao,
    required this.flagMensagem,
    required this.fakeDelete,
    required this.lida,
    this.titulo,
    this.subtitulo,
  });
}

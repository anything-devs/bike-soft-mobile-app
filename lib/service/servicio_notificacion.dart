import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotification() async {
  const AndroidInitializationSettings inicializacionConfiguracionAndroid =
      AndroidInitializationSettings('app_icon');

  const InitializationSettings configuracionInicial =
      InitializationSettings(android: inicializacionConfiguracionAndroid);

  await flutterLocalNotificationsPlugin.initialize(configuracionInicial);
}

Future<void> mostrarNotificacion(String titulo, String cuerpo) async {
  const AndroidNotificationDetails notificacionAndroid =
      AndroidNotificationDetails(
          "Notificacion i", "Contenido de la notificacion");

  const NotificationDetails detallesNotificacion =
      NotificationDetails(android: notificacionAndroid);

  await flutterLocalNotificationsPlugin.show(
      1, titulo, cuerpo, detallesNotificacion);
}

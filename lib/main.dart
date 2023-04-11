import 'package:bike_soft_mobile_app/screens/pantalla_productos.dart';
import 'package:bike_soft_mobile_app/screens/pantalla_acualizar_cantidad.dart';
import 'package:bike_soft_mobile_app/screens/pantalla_acualizar_producto.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeData theme = ThemeData(primarySwatch: Colors.grey);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
          colorScheme:
              theme.colorScheme.copyWith(secondary: Colors.red.shade500)),
      initialRoute: '/',
      routes: {
        '/': (context) => const PantallaProductos(),
        '/actualizarProductos': (context) => const ActProductsScreen(),
        '/actualizarProducto': (context) => const ActProductScreen(),
      },
    );
  }
}

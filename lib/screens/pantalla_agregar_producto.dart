import 'package:flutter/material.dart';

class PantallaAgregarProducto extends StatefulWidget {
  const PantallaAgregarProducto({super.key});

  @override
  State<PantallaAgregarProducto> createState() =>
      _PantallaAgregarProductoState();
}

class _PantallaAgregarProductoState extends State<PantallaAgregarProducto> {
  final _controladorTexto = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop('');
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _controladorTexto,
                decoration: const InputDecoration(labelText: 'Nuevo Elemento'),
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(_controladorTexto.text);
                  },
                  child: const Text('Agregar'))
            ],
          ),
        ),
      ),
    );
  }
}

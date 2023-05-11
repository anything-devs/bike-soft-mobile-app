import 'dart:convert';
import 'dart:io';

import 'package:bike_soft_mobile_app/models/producto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ControladorProductos {
  Future<List<Producto>> getProductos(String filtro) async {
    var url = Uri.parse("http://10.0.2.2:8080/$filtro");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Producto.fromJson(json)).toList();
    } else {
      throw Exception("Error al&parseTime=true obtener productos");
    }
  }

  Future<List<Producto>> getProductosBajasUnidades() async {
    var url =
        Uri.parse("http://10.0.2.2:8080/productos/filtradosBajasUnidades/5");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Producto.fromJson(json)).toList();
    } else {
      throw Exception("Error al obtener productos");
    }
  }

  Future<List<Producto>> getProducto(String id) async {
    final regex = RegExp(r'\d');
    bool codigo = regex.hasMatch(id);
    Uri url;
    if (codigo) {
      url = Uri.parse("http://10.0.2.2:8080/producto?codigo=$id");
    } else {
      url = Uri.parse("http://10.0.2.2:8080/producto?nombre=$id");
    }

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Producto.fromJson(json)).toList();
      } else {
        throw Exception("Error al&parseTime=true obtener productos");
      }
    } catch (e) {
      return [];
    }
  }

  Future<bool> putProducto(Producto producto) async {
    final Map<String, dynamic> data = {'cantidad': producto.cantidad};
    var url = Uri.parse(
        "http://10.0.2.2:8080/productoActualizarStock/${producto.id.toString()}");
    final response = await http.put(url,
        headers: {"content-type": "application/json"},
        body: jsonEncode({'cantidad': producto.cantidad}));

    if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }

  }

  
  Future<bool> deleteProducto(Producto producto) async {
    var url = Uri.parse("http://10.0.2.2:8080/productoEliminar/${producto.id.toString()}"); 
      final response = await http.delete(url);

    if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }

  void crearProducto(BuildContext context, Producto producto) {
    showDialog(
      context: context,
      builder: (context) {
        // Guardar el contexto en una variable local
        return FutureBuilder<void>(
          future: _crearProductoAsync(producto),
          builder: (context, snapshot) {
            // Usar la variable local en lugar del contexto original
            return AlertDialog(
              title: Text(snapshot.hasError
                  ? 'Error al guardar datos'
                  : 'Datos guardados'),
              content: Text(snapshot.hasError
                  ? 'Ha ocurrido un error al intentar guardar los datos.'
                  : 'Los datos se han guardado correctamente.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _crearProductoAsync(Producto producto) async {
    //certificadoSSL();
    final url = Uri.parse('http://10.0.2.2:8080/productoCrear');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(producto.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Ha ocurrido un error al intentar guardar los datos.');
    }
  }
}

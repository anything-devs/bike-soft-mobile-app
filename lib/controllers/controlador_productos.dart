import 'dart:convert';

import 'package:bike_soft_mobile_app/models/producto.dart';
import 'package:http/http.dart' as http;

class ControladorProductos {
  Future<List<Producto>> getProductos() async {
    var url = Uri.parse("http://10.0.2.2:8080/productos");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Producto.fromJson(json)).toList();
    } else {
      throw Exception("Error al obtener productos");
    }
  }
}

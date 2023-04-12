import 'dart:ffi';

class Producto {
  final int id;
  final String codigo;
  final String nombre;
  final Float precioBase;
  final Float? precioVenta;
  final Uint16 cantidad;
  final Uint8 cantidadMinima;

  Producto(
      {required this.id,
      required this.codigo,
      required this.nombre,
      required this.precioBase,
      required this.precioVenta,
      required this.cantidad,
      required this.cantidadMinima});

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
        id: json['ID'],
        codigo: json['codigo'],
        nombre: json['nombre'],
        precioBase: json['precio_base'],
        precioVenta: json['precio_venta'],
        cantidad: json['cantidad'],
        cantidadMinima: json['cantidad_minima']);
  }
}

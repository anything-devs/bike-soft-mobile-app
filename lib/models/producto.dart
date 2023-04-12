class Producto {
  final int id;
  final String codigo;
  final String nombre;
  final double precioBase;
  final double precioVenta;
  final int cantidad;
  final int? cantidadMinima;

  Producto(
      {required this.id,
      required this.codigo,
      required this.nombre,
      required this.precioBase,
      required this.precioVenta,
      required this.cantidad,
      this.cantidadMinima});

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
        id: json['ID'],
        codigo: json['codigo'],
        nombre: json['nombre'],
        precioBase: double.parse(json['precio_base'].toString()),
        precioVenta: double.parse(json['precio_venta'].toString()),
        cantidad: json['cantidad'],
        cantidadMinima: json['cantidad_minima']);
  }
}

class Producto {
  final int? id;
  final String codigo;
  final String nombre;
  final double precioBase;
  final double? precioVenta;
  int cantidad;
  final int? cantidadMinima;
  final int? categoriaId;

  Producto(
      {this.id,
      required this.codigo,
      required this.nombre,
      required this.precioBase,
      this.precioVenta,
      required this.cantidad,
      this.cantidadMinima,
      this.categoriaId});

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
        id: json['ID'],
        codigo: json['codigo'],
        nombre: json['nombre'],
        precioBase: double.parse(json['precio_base'].toString()),
        precioVenta: double.parse(json['precio_venta'].toString()),
        cantidad: json['cantidad'],
        cantidadMinima: json['cantidad_minima'],
        categoriaId: json['categoria_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'nombre': nombre,
      'precio_base': precioBase,
      'cantidad': cantidad,
      'categoria_id': categoriaId
    };
  }

  @override
  String toString() {
    return 'Producto {nombre: $codigo, descripcion: $nombre, precio base: $precioBase, cantidad: $cantidad, categoria: $categoriaId}';
  }
}

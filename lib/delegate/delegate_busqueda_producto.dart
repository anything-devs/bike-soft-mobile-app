import 'package:flutter/material.dart';
import 'package:bike_soft_mobile_app/controllers/controlador_productos.dart';
import 'package:bike_soft_mobile_app/models/producto.dart';

class BusquedaProducto extends SearchDelegate<Producto> {
  /*final ControladorProductos _controladorProducto = ControladorProductos();

  Future<List<Producto>> _getProducto(String id) async {
    final productoBD = await _controladorProducto.getProductos('productos-AZ');
    return productoBD;
  }*/

  @override
  String get searchFieldLabel => 'ID o nombre del producto';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close_outlined),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container(
          alignment: Alignment.center,
          child: const Text(
              'Ingrese el Código o Nombre de un producto existente.'));
    }

    final controladorProducto = ControladorProductos();

    return FutureBuilder(
        future: controladorProducto.getProducto(query),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const ListTile(title: Text('No hay nada con ese término'));
          }
          if (snapshot.hasData) {
            return _showProductos(snapshot.data);
          } else {
            return const Center(
                child: CircularProgressIndicator(strokeWidth: 4));
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
    //sugerencias de busqeuda
  }

  Widget _showProductos(List<Producto> productos) {
    return ListView.builder(
      itemCount: productos.length,
      itemBuilder: (context, i) {
        final producto = productos[i];

        return ListTile(
          leading: const CircleAvatar(
            backgroundImage: NetworkImage(
              "https://media.istockphoto.com/id/1344641306/es/foto/bicicleta-de-grava-profesional-o-bicicleta-de-carretera-aislada-sobre-fondo-blanco.jpg?s=612x612&w=is&k=20&c=_7cFRa-IpRlhsO7ilAtmf_NWcdaJGSXKgl3dmdss7Ek=",
            ),
          ),
          title: Text(
            producto.nombre,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          subtitle: Text(
              "Cantidad : ${producto.cantidad.toString()}      Precio: ${producto.precioBase.toString()} "),
          onTap: () {
            close(context, producto);
          },
        );
      },
    );
  }
}

import 'package:bike_soft_mobile_app/models/producto.dart';
import 'package:flutter/material.dart';
import 'package:bike_soft_mobile_app/delegate/delegate_busqueda_producto.dart';

class CustomAppBarr extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarr({super.key, this.titulo = '', this.iconoBuscar = true});
  final bool iconoBuscar;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      centerTitle: true,
      backgroundColor: const Color(0xff2a2b30),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0))),
      title: Text(
        titulo,
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 19,
            color: Colors.white),
      ),
      actions: [
        if (iconoBuscar)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: IconButton(
              icon: const Icon(Icons.search),
              color: const Color(0xffffffff),
              iconSize: 24,
              onPressed: () async {
                final productoSeleccionado = await showSearch(
                      context: context,
                      delegate: BusquedaProducto()
                      );
              },
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(0, 70);
}

import 'package:bike_soft_mobile_app/delegate/delegate_busqueda_producto.dart';
import 'package:bike_soft_mobile_app/controllers/controlador_productos.dart';
import 'package:bike_soft_mobile_app/models/producto.dart';
import 'package:bike_soft_mobile_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class ActProductsScreen extends StatefulWidget {
  const ActProductsScreen({super.key});

  @override
  State<ActProductsScreen> createState() => _ActProductsScreenState();
}

class _ActProductsScreenState extends State<ActProductsScreen> {
  List<Producto> productos = [];
  Producto? productoSeleccionado;
  final ControladorProductos _controladorProducto = ControladorProductos();

  Future<void> _putCantidad() async {
    for (var producto in productos) {
      await _controladorProducto.putProducto(producto);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff2a2b30),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0))),
        title: const Text(
          "Actualizar Productos",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 19,
              color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: IconButton(
              icon: const Icon(Icons.search),
              color: const Color(0xffffffff),
              iconSize: 24,
              onPressed: () async {
                productoSeleccionado = await showSearch(
                    context: context, delegate: BusquedaProducto());
                if (productoSeleccionado != null &&
                    productos.contains(productoSeleccionado) == false) {
                  setState(() {
                    productos.add(productoSeleccionado!);
                  });
                }
              },
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(page: 'Actulizar Productos'),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
              )),
          if (productos.isNotEmpty) _listViewProductos()
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.red.shade400,
          hoverColor: Colors.red.shade300,
          icon: const Icon(Icons.add_business_outlined, color: Colors.white),
          label: const Text(
            "Actualizar Stock",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          onPressed: () => {_putCantidad(), Navigator.pushNamed(context, '/')}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _listViewProductos() {
    return SizedBox(
        height: 800,
        child: ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final producto = productos[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://media.istockphoto.com/id/1344641306/es/foto/bicicleta-de-grava-profesional-o-bicicleta-de-carretera-aislada-sobre-fondo-blanco.jpg?s=612x612&w=is&k=20&c=_7cFRa-IpRlhsO7ilAtmf_NWcdaJGSXKgl3dmdss7Ek=",
                  ),
                ),
                title: Text(
                  producto.nombre,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
                subtitle: Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Nuevas Existencias',
                        border: UnderlineInputBorder()),
                    onSubmitted: (value) {
                      if (value.isNotEmpty && value != "") {
                        for (var element in productos) {
                          if (element.nombre == producto.nombre) {
                            element.cantidad += int.parse(value);
                          }
                        }
                      }
                    },
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_forever_outlined),
                  onPressed: () => {
                    setState(() {
                      productos.remove(producto);
                    })
                  },
                ),
              );
            }));
  }
}

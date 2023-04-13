import 'package:bike_soft_mobile_app/controllers/controlador_productos.dart';
import 'package:bike_soft_mobile_app/models/producto.dart';
import 'package:bike_soft_mobile_app/widgets/custom_app_bar.dart';
import 'package:bike_soft_mobile_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class PantallaProductos extends StatefulWidget {
  const PantallaProductos({super.key});

  @override
  State<PantallaProductos> createState() => _PantallaProductosState();
}

class _PantallaProductosState extends State<PantallaProductos> {
  // Datos que se usan en lista productos.
  final List<String> list = <String>["A-Z", "Z-A", "Bajas unidades"];
  String _dropDownValue = 'A-Z';
  // Datos almacenados traidos por una peticion a backend
  final ControladorProductos _controladorProducto = ControladorProductos();
  List<Producto> _productos = [];
  // Control de cargo
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _getProductos('productos-AZ');
  }

  Future<void> _getProductos(String filtro) async {
    await Future.delayed(const Duration(seconds: 2));
    final productos = await _controladorProducto.getProductos(filtro);
    setState(() {
      _productos = productos;
      _cargando = false;
    });
  }

  Future<void> _getProductosBajasUnidades() async {
    final productos = await _controladorProducto.getProductosBajasUnidades();
    setState(() {
      _productos = productos;
      _cargando = false;
    });
  }

  Widget _cargandoProductos() {
    return Expanded(
        child: Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarr(titulo: "Productos", iconoBuscar: false),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [dropDownValues()],
            ),
          ),
          if (_cargando) _cargandoProductos(),
          _listViewProductos()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/agregarProducto');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _listViewProductos() {
    return Expanded(
        child: ListView.builder(
            itemCount: _productos.length,
            itemBuilder: (context, index) {
              final producto = _productos[index];
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
                subtitle: Text(producto.precioVenta.toString()),
                trailing: Text(producto.cantidad.toString()),
              );
            }));
  }

  Container dropDownValues() {
    return Container(
        width: 180,
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
            color: const Color(0xff787878),
            borderRadius: BorderRadius.circular(10)),
        child: DropdownButtonHideUnderline(
            child: DropdownButton(
          value: _dropDownValue,
          onChanged: (filtro) {
            setState(() {
              _dropDownValue = filtro!;
              if (_dropDownValue == 'Bajas unidades') {
                _getProductosBajasUnidades();
              } else if (_dropDownValue == 'Z-A') {
                _getProductos('productos-ZA');
              } else {
                _getProductos('productos-AZ');
              }
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          elevation: 8,
          alignment: Alignment.center,
          isExpanded: true,
        )));
  }
}

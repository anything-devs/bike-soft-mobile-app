import 'package:bike_soft_mobile_app/controllers/controlador_productos.dart';
import 'package:bike_soft_mobile_app/models/producto.dart';
import 'package:bike_soft_mobile_app/widgets/custom_app_bar.dart';
import 'package:bike_soft_mobile_app/widgets/custom_drawer.dart';
import 'package:bike_soft_mobile_app/widgets/custom_alert_dialog.dart';
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
    _cargando = true;
    _productos = [];
    await Future.delayed(const Duration(seconds: 1));
    final productos = await _controladorProducto.getProductos(filtro);
    setState(() {
      _productos = productos;
      _cargando = false;
    });
  }

  Future<void> _getProductosBajasUnidades() async {
    _cargando = true;
    _productos = [];
    await Future.delayed(const Duration(seconds: 1));
    final productos = await _controladorProducto.getProductosBajasUnidades();
    setState(() {
      _productos = productos;
      _cargando = false;
    });
  }

  Future<Widget> _deleteProducto(producto) async {
    if (producto.cantidad != 0) {
      return const CustomAlertDialog(
        titulo: "No se puede ejecutar la accion",
        mensaje:
            "No se pueden eliminar productos que cuenten con unidades en inventario",
        icono: Icon(
          Icons.warning_amber_rounded,
          size: 70,
        ),
        color: Colors.red,
      );
    }

    final respuesta = await _controladorProducto.deleteProducto(producto);
    if (respuesta) {
      return const CustomAlertDialog(
        titulo: "Accion realizada",
        mensaje: "El producto se ha eliminado correctamente",
        icono: Icon(
          Icons.check_circle_outline_rounded,
          size: 70,
        ),
        color: Colors.green,
      );
    } else {
      return const CustomAlertDialog(
        titulo: "Error al ejecutar la accion",
        mensaje:
            "Ha ocurrido un error a la hora de eliminar este producto, revise su conexión e inténtelo más tarde",
        icono: Icon(
          Icons.warning_amber_rounded,
          size: 70,
        ),
        color: Colors.red,
      );
    }
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
      drawer: const CustomDrawer(page: "Productos"),
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
          _listViewProductos(context)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/agregarProducto');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _listViewProductos(context) {
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
                subtitle: Text(
                    "Cantidad : ${producto.cantidad.toString()}      Precio : ${producto.precioVenta.toString()} "),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_forever_outlined),
                  onPressed: () => {
                    setState(() {
                      confirmDelete(context, producto);
                    })
                  },
                ),
              );
            }));
  }

  Container dropDownValues() {
    return Container(
        width: 180,
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
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

  confirmDelete(context, producto) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            icon: const Icon(
              Icons.warning_amber_rounded,
              size: 70,
            ),
            iconColor: Colors.red.shade500,
            backgroundColor: Colors.white,
            elevation: 24,
            title: Text("Se eliminará el producto : ${producto.nombre}"),
            content: const Text(
              "Esta acción no se puede deshacer ¿Deseas continuar?",
              textAlign: TextAlign.center,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 120,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return FutureBuilder(
                                  future: _deleteProducto(producto),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<Widget> respuesta) {
                                    if (respuesta.connectionState == ConnectionState.done) {
                                        return respuesta.data!; 
                                    } else {
                                      return _cargandoProductos();
                                    }
                                  });
                            }));
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green.shade100),
                      ),
                      child: const Text(
                        "Aceptar",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red.shade100),
                      ),
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }));
  }
}

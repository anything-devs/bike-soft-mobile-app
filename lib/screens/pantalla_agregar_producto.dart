import 'package:bike_soft_mobile_app/controllers/controlador_productos.dart';
import 'package:bike_soft_mobile_app/widgets/custom_alert_dialog.dart';
import 'package:bike_soft_mobile_app/models/categoria.dart';
import 'package:bike_soft_mobile_app/models/producto.dart';
import 'package:flutter/material.dart';

class PantallaAgregarProducto extends StatefulWidget {
  const PantallaAgregarProducto({super.key});

  @override
  State<PantallaAgregarProducto> createState() =>
      _PantallaAgregarProductoState();
}

class _PantallaAgregarProductoState extends State<PantallaAgregarProducto> {
  final _controladorProducto = ControladorProductos();
  Producto? _producto;
  final _llaveFormulario = GlobalKey<FormState>();

  final List<Categoria> _categorias = [
    Categoria(id: 1, nombre: 'Pachas'),
    Categoria(id: 2, nombre: 'Pedales'),
    Categoria(id: 3, nombre: 'Timones')
  ];

  final _codigoControlador = TextEditingController();
  final _nombreControlador = TextEditingController();
  final _precioBaseControlador = TextEditingController();
  final _cantidadControlador = TextEditingController();

  int? _categoriaSeleccionada;
  String? categoriaSeleccionada;
  String? errorCategoria;

  @override
  void dispose() {
    _codigoControlador.dispose();
    _nombreControlador.dispose();
    _precioBaseControlador.dispose();
    _cantidadControlador.dispose();
    super.dispose();
  }

  Future<Widget> _crearProducto(producto) async {
    final respuesta = await _controladorProducto.crearProducto(producto);
    if (respuesta) {
      return const CustomAlertDialog(
        titulo: "Producto creado",
        mensaje: "Los datos del producto se han guardado correctamente",
        icono: Icon(
          Icons.check_circle_outline_rounded,
          size: 70,
        ),
        color: Colors.green,
      );
    } else {
      return const CustomAlertDialog(
        titulo: "Error al crear el producto",
        mensaje:
            "Ha ocurrido un error a la hora de crear este producto, revise su conexión e inténtelo más tarde",
        icono: Icon(
          Icons.warning_amber_rounded,
          size: 70,
        ),
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop('');
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
              child: Form(
                key: _llaveFormulario,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios)),
                          const Text(
                            "Agregar producto",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    //Codigo del producto
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 15),
                      child: TextFormField(
                        controller: _codigoControlador,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Codigo del producto'),
                        validator: validarCodigoProducto,
                      ),
                    ),
                    //Nombre producto
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 15),
                      child: TextFormField(
                        controller: _nombreControlador,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nombre del producto'),
                        validator: validarNombreProducto,
                      ),
                    ),
                    //Precio base
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 15),
                      child: TextFormField(
                        controller: _precioBaseControlador,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Precio base"),
                        keyboardType: TextInputType.number,
                        validator: validarPrecioBase,
                      ),
                    ),
                    // Cantidad del producto
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 15),
                        child: TextFormField(
                          controller: _cantidadControlador,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Ingrese cantidad"),
                          keyboardType: TextInputType.number,
                          validator: validarCantidad,
                        )),
                    // Categoria
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
                      child: Container(
                        width: 180,
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: errorCategoria != null
                                    ? Colors.red
                                    : Theme.of(context).colorScheme.primary,
                                width: 1)),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                          value: _categoriaSeleccionada,
                          items: _categorias.map((Categoria categoria) {
                            return DropdownMenuItem<int>(
                                value: categoria.id,
                                child: Text(categoria.nombre));
                          }).toList(),
                          onChanged: (filtro) {
                            validarCategoria(int.parse(filtro.toString()));
                            setState(() {});
                          },
                          hint: const Text('Selecciona categoria'),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          elevation: 8,
                          alignment: Alignment.center,
                          isExpanded: true,
                        )),
                      ),
                    ),
                    if (errorCategoria != null)
                      Text(
                        errorCategoria!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              )),
          floatingActionButton: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 45.0,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_llaveFormulario.currentState!.validate() &&
                        _categoriaSeleccionada != 0) {
                      _guardarProduto();
                      Navigator.pushNamed(context, '/');
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return FutureBuilder(
                                future: _crearProducto(_producto),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Widget> respuesta) {
                                  if (respuesta.connectionState ==
                                      ConnectionState.done) {
                                    return respuesta.data!;
                                  } else {
                                    return Expanded(
                                        child: Container(
                                        alignment: Alignment.center,
                                        child: const CircularProgressIndicator(),
                                    ));
                                  }
                                });
                          }));
                    } else {
                      setState(() {
                        errorCategoria = "Seleccione una categoria";
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  label: const Text("Guardar",
                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      backgroundColor: Colors.red.shade400,
                      surfaceTintColor: Colors.red.shade300),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ));
  }

  // Guardar un nuevo producto
  void _guardarProduto() async {
    if (_codigoControlador.text.isNotEmpty &&
        _nombreControlador.text.isNotEmpty &&
        _precioBaseControlador.text.isNotEmpty &&
        _cantidadControlador.text.isNotEmpty &&
        _categoriaSeleccionada != null) {
      _producto = Producto(
          codigo: _codigoControlador.text,
          nombre: _nombreControlador.text,
          precioBase: double.parse(_precioBaseControlador.text),
          cantidad: int.parse(_cantidadControlador.text),
          categoriaId: _categoriaSeleccionada);
    }
  }

  // Validadores
  String? validarCodigoProducto(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese el codigo del producto';
    } else if (value.length < 5) {
      return 'El codigo del producto debe tener al menos 5 caracteres';
    }
    return null;
  }

  String? validarNombreProducto(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese el Nombre del producto';
    }
    return null;
  }

  String? validarPrecioBase(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese el precio base del producto';
    }
    final double? precio = double.tryParse(value);
    if (precio == null || precio <= 0) {
      return 'Ingrese un precio valido';
    }
    return null;
  }

  String? validarCantidad(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese la cantidad del producto';
    }
    final double? precio = double.tryParse(value);
    if (precio == null || precio <= 0) {
      return 'Ingrese un cantidad valida';
    }
    return null;
  }

  void validarCategoria(int filtro) {
    setState(() {
      errorCategoria = null;
      _categoriaSeleccionada = filtro;
    });
  }
}

import 'package:flutter/material.dart';

class PantallaAgregarProducto extends StatefulWidget {
  const PantallaAgregarProducto({super.key});

  @override
  State<PantallaAgregarProducto> createState() =>
      _PantallaAgregarProductoState();
}

class _PantallaAgregarProductoState extends State<PantallaAgregarProducto> {
  //final _controladorTexto = TextEditingController();
  final List<String> _categorias = <String>["Ruedas", "Cadenas", "Timones"];
  String _categoriaSeleccionada = "Ruedas";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop('');
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
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
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre del producto'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Precio base"),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Ingrese cantidad"),
                    keyboardType: TextInputType.number,
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15.0),
                  child: Container(
                    width: 180,
                    height: 40,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: categoriasDropDown(),
                  )),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      backgroundColor: Colors.red.shade400,
                      surfaceTintColor: Colors.red.shade300),
                  child: const Text(
                    "Guardar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  DropdownButtonHideUnderline categoriasDropDown() {
    return DropdownButtonHideUnderline(
        child: DropdownButton(
      value: _categoriaSeleccionada,
      items: _categorias.map((String categoria) {
        return DropdownMenuItem<String>(
            value: categoria, child: Text(categoria));
      }).toList(),
      onChanged: (filtro) {
        setState(() {
          _categoriaSeleccionada = filtro!;
        });
      },
      hint: const Text('Selecciona categoria'),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      elevation: 8,
      alignment: Alignment.center,
      isExpanded: true,
    ));
  }
}

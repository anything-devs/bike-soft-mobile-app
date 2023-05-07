import 'package:bike_soft_mobile_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

const List<String> categorias = <String>[
  "Categoria1",
  "Categoria2",
  "Categoria3"
];
String categoriaSelect = categorias.first;

class ActProductScreen extends StatefulWidget {
  const ActProductScreen({super.key});

  @override
  State<ActProductScreen> createState() => _ActProductScreenState();
}

class _ActProductScreenState extends State<ActProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarr(
        titulo: "Actualizar Producto",
        iconoBuscar: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Form(
          child: Column(children: [
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  labelText: 'Nombre', prefixIcon: Icon(Icons.abc_rounded)),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Precio',
                  prefixIcon: Icon(Icons.attach_money_outlined)),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cantidad',
                prefixIcon: Icon(Icons.numbers_rounded),
              ),
            ),
            DropdownButtonFormField(
              value: categoriaSelect,
              items: categorias.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  categoriaSelect = value!;
                });
              },
              icon: const Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Colors.red,
              ),
              decoration: const InputDecoration(
                labelText: 'Categoria',
                prefixIcon: Icon(Icons.category_rounded),
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red.shade500,
        hoverColor: Colors.red.shade400,
        icon: const Icon(Icons.save, color: Colors.white),
        label: const Text(
          "Guardar",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        onPressed: () => {Navigator.pushNamed(context, '/actualizarProductos')},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

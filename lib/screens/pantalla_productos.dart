import 'package:bike_soft_mobile_app/widgets/custom_app_bar.dart';
import 'package:bike_soft_mobile_app/widgets/custom_drawer.dart';
import 'package:bike_soft_mobile_app/screens/pantalla_agregar_producto.dart';
import 'package:flutter/material.dart';

class PantallaProductos extends StatefulWidget {
  const PantallaProductos({super.key});

  @override
  State<PantallaProductos> createState() => _PantallaProductosState();
}

class _PantallaProductosState extends State<PantallaProductos> {
  final List<String> list = <String>["A-Z", "Z-A", "Bajas unidades"];
  String dropDownValue = 'A-Z';

  // Esto es el test para la lista
  final List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  Future<void> _mostrarPantallaAgregar() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const PantallaAgregarProducto()));
  }
  // hasta aca va los del test para listas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarr(titulo: "Productos", iconoBuscar: true),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [valueItems()],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://media.istockphoto.com/id/1344641306/es/foto/bicicleta-de-grava-profesional-o-bicicleta-de-carretera-aislada-sobre-fondo-blanco.jpg?s=612x612&w=is&k=20&c=_7cFRa-IpRlhsO7ilAtmf_NWcdaJGSXKgl3dmdss7Ek=",
                      ),
                    ),
                    title: Text(items[index]),
                    subtitle: Text(items[index]),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarPantallaAgregar();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Container valueItems() {
    return Container(
        width: 180,
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
            color: const Color(0xff787878),
            borderRadius: BorderRadius.circular(10)),
        child: DropdownButtonHideUnderline(
            child: DropdownButton(
          value: dropDownValue,
          onChanged: (String? value) {
            setState(() {
              dropDownValue = value!;
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

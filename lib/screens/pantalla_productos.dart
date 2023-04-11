import 'package:bike_soft_mobile_app/widgets/custom_app_bar.dart';
import 'package:bike_soft_mobile_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<String> list = <String>["A-Z", "Z-A", "Bajas unidades"];
  String dropDownValue = 'A-Z';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBarr(titulo: "Productos"),
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://media.istockphoto.com/id/1344641306/es/foto/bicicleta-de-grava-profesional-o-bicicleta-de-carretera-aislada-sobre-fondo-blanco.jpg?s=612x612&w=is&k=20&c=_7cFRa-IpRlhsO7ilAtmf_NWcdaJGSXKgl3dmdss7Ek=",
                        ),
                      ),
                      title: Text('Item $index'),
                      subtitle: Text('Item bueno $index'),
                    );
                  }),
            )
          ],
        ));
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

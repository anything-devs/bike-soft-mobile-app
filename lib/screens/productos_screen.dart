import 'package:bike_soft_mobile_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarr(titulo: "Productos"),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [valueItems()],
              ))

          //Aca van el resto de cosas
        ],
      ),
    );
  }

  Container valueItems() {
    const List<String> list = <String>["A-Z", "Z-A", "Bajas unidades"];
    String dropDownValue = list.first;
    return Container(
      width: 150,
      height: 35,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          color: const Color(0xff787878),
          borderRadius: BorderRadius.circular(10)),
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
            color: Colors.black, fontSize: 11, fontWeight: FontWeight.w600),
        elevation: 8,
        isExpanded: true,
      ),
    );
  }
}

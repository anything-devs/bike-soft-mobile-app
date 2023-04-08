import 'package:bike_soft_mobile_app/widgets/custom_app_bar.dart';
import 'package:bike_soft_mobile_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class ActProductsScreen extends StatefulWidget {
  const ActProductsScreen({super.key});

  @override
  State<ActProductsScreen> createState() => _ActProductsScreenState();
}

class _ActProductsScreenState extends State<ActProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarr(titulo: "Actualizar Productos"),
      drawer: const CustomDrawer(),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                //children: [valueItems()],
              )),
        ],
      ),
    );
  }

  
}

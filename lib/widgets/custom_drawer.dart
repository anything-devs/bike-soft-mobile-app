import 'package:flutter/material.dart';


class CustomDrawer extends StatelessWidget  {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text("Topo"),
                accountEmail: const Text("UserTopo1524"),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network("https://p77-va.tiktokcdn.com/musically-maliva-obj/954c4e486850293d5efb88286edce9f3~c5_720x720.jpeg"),
                  ),
                ),
                // se modificara posteriormente para recibir las credenciales y opcionalmente una imagen, esto por parametros
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
               ),

               
              ExpansionTile(
                leading: const Icon(Icons.inventory_2_outlined),
                title: const Text('Inventario'),
                expandedAlignment: Alignment.bottomLeft,
                children: [
                  ListTile(
                    title: const Text('Productos'),
                    onTap: () => {
                      Navigator.pushNamed(context, '/'),
                    },
                  ),
                  ListTile(
                    title: const Text('Actulizar Productos'),
                    onTap: () => {
                      Navigator.pushNamed(context, '/actualizarProductos'),
                    }
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.insert_invitation_outlined),
                title: const Text('Servicios'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.inventory_rounded),
                title: const Text('Reportes'),
                onTap: () {},
              ),
            ],
          ),
    );
  }

}

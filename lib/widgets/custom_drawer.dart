import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, this.page = ""});
  final String page;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Topo"),
            accountEmail: const Text("UserTopo1524"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                    "https://p77-va.tiktokcdn.com/musically-maliva-obj/954c4e486850293d5efb88286edce9f3~c5_720x720.jpeg"),
              ),
            ),
            // se modificara posteriormente para recibir las credenciales y opcionalmente una imagen, esto por parametros
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://i.ibb.co/BydYpDV/cadena-4.jpg"),
                alignment: Alignment.bottomRight,
              ),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.center,
                colors: [
                  Colors.grey,
                  Colors.white,
                ],
                stops: [0.0,0.85]
              ),
            ),
          ),
          ExpansionTile(
            leading: const Icon(Icons.inventory_2_outlined),
            title: const Text('Inventario'),
            backgroundColor: Colors.grey.shade200,
            textColor: Colors.black,
            iconColor: Colors.black,
            expandedAlignment: Alignment.bottomLeft,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20)),
            collapsedTextColor:
                page == 'Productos' || page == 'Actulizar Productos'
                    ? Colors.red.shade500
                    : null,
            collapsedIconColor:
                page == 'Productos' || page == 'Actulizar Productos'
                    ? Colors.red.shade500
                    : null,
            children: [
              ListTile(
                title: const Text('Productos'),
                textColor: page == 'Productos' ? Colors.red.shade500 : null,
                onTap: () => {
                  Navigator.pushNamed(context, '/'),
                },
              ),
              ListTile(
                  title: const Text('Actulizar Productos'),
                  textColor: page == 'Actulizar Productos'
                      ? Colors.red.shade500
                      : null,
                  onTap: () => {
                        Navigator.pushNamed(context, '/actualizarProductos'),
                      }),
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

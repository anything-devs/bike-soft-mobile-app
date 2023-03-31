import 'package:flutter/material.dart';

class CustomAppBarr extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarr({super.key, this.titulo = ''});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: const Color(0xff2a2b30),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0))),
      title: Text(
        titulo,
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 19,
            color: Colors.white),
      ),
      leading: const Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: Icon(
          Icons.menu,
          color: Color(0xffffffff),
          size: 24,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
          child: Icon(
            Icons.search,
            color: Color(0xffffffff),
            size: 24,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(0, 70);
}

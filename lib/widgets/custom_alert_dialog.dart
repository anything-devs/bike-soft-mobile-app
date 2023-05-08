import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog ({super.key, this.titulo = '', this.mensaje = ''
  , this.icono = const Icon (Icons.warning), this.color = const  Color(0xFFF44336)});
  final String titulo;
  final String mensaje;
  final Icon icono;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icono,
      iconColor: color,
      backgroundColor: Colors.white,
      elevation: 24,
      title: Text(titulo),
      content: Text(
        mensaje,
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 120,
              height: 50,
              child: 
              TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green.shade100),
              ),
              child: const Text(
                "Aceptar",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            ),
            
          ],
        ),
      ],
    );
  }
  
  

}
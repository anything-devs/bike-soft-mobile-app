
import 'package:flutter/material.dart';


class BusquedaProducto extends SearchDelegate{

  @override
  String get searchFieldLabel => 'ID o nombre del producto';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
            icon: Icon(Icons.manage_search_sharp),
            onPressed: () {
            },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("Conectese a la BD primero");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text("");
    //sugerencias de busqeuda
  }

}
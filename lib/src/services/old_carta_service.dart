import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Categoria {
  String nombreCategoria;
  String color;
  String icono;
  List<Articulo> articulos;
}

class Articulo {
  String nombreArticulo;
  String ingredientes;
  String precio;
}

class Carta {
  List<Categoria> categorias;

  Carta({this.categorias});

  factory Carta.fromJson(Map<String, dynamic> parsedJson) {
    
    List<Categoria> tempCategorias;

    for (String k in parsedJson.keys) {
      print("Key : $k, value : ${parsedJson[k]}");
    }


    return Carta(
        //categorias[0].nombreCategoria = parsedJson['nombreCategoria'][0]

        //studentId: parsedJson['id'],
        //studentName: parsedJson['name'],
        //studentScores: parsedJson['score']
        );
  }

  Future<String> _loadCartaJsonAsset() async {
    return await rootBundle.loadString('assets/carta.json');
  }

  Future<Carta> loadCarta() async {
    String jsonString = await _loadCartaJsonAsset();
    final jsonResponse = json.decode(jsonString);
    print(jsonResponse);
    return new Carta.fromJson(jsonResponse);
  }

  List<dynamic> carta = [];
  String cadenacarta;

  //Carta() {
  //  cadenacarta = cargarData();
  //}

  String cargarData() {
    rootBundle.loadString('assets/carta.json').then((data) {
      print(data);
      return data;
    });
    return "";
  }
}

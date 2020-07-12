//import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter_don_salvatore/src/models/carta_model.dart';


class CartaService {
  
  void cargarCarta() async{   
    final CartaModel cartaModelo = await loadCarta();
  }


  Future<String> _loadCartaJsonAsset() async {
    return await rootBundle.loadString('assets/carta.json');
  }

  Future<CartaModel> loadCarta() async {    
    String jsonString = await _loadCartaJsonAsset();
    final CartaModel modeloCarta = cartaModelFromJson(jsonString);
    return modeloCarta;
    //return cartaModelFromJson(jsonString);

    //final jsonResponse = json.decode(jsonString);
    //print(jsonResponse);
    //return new CartaModel.fromJson(jsonResponse);
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

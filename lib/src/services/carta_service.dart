//import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter_don_salvatore/src/models/carta_model.dart';

class CartaService {
  Future<String> _loadCartaJsonAsset() async {
    return await rootBundle.loadString('assets/carta.json');
  }

  Future<CartaModel> loadCarta() async {
    String jsonString = await _loadCartaJsonAsset();
    final CartaModel modeloCarta = cartaModelFromJson(jsonString);
    return modeloCarta;
  }
}

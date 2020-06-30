import 'package:flutter/services.dart' show rootBundle;

class CartaService {
  List<dynamic> carta = [];
  String cadenacarta;

  CartaService() {
    cadenacarta = cargarData();
  }

  String cargarData() {
    rootBundle.loadString('assets/carta.json').then((data) {
      print(data);
      return data;
    });
    return "";
  }
}

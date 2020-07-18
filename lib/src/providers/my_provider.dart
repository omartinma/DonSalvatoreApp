import 'package:flutter/cupertino.dart';

class MyProvider with ChangeNotifier {
  String _categoriaSeleccionada = '';

  get categoriaSeleccionada {
    return _categoriaSeleccionada;
  }

  set categoriaSeleccionada(categoriaSeleccionada) {
    this._categoriaSeleccionada = categoriaSeleccionada;
    notifyListeners();
  }
}

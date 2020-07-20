import 'package:flutter/material.dart';

import 'package:flutter_don_salvatore/src/models/carta_model.dart';
import 'package:flutter_don_salvatore/src/services/carta_service.dart';
import 'package:flutter_don_salvatore/src/widgets/lista_articulos.dart';

CartaModel miCarta = new CartaModel();
String categoriaSeleccionada = "";
List<Articulo> articulos = [];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ListaCategorias(),
            // Contenedor que ocupa la pantalla entera menos 150 que es lo que le deja a ListaCategorias para darle su alto
            Container(
              height: MediaQuery.of(context).size.height - 150,
              child: ListaArticulos(articulos),
            ),
          ],
        ),
      ),
    );
  }
}

class ListaCategorias extends StatefulWidget {
  @override
  _ListaCategoriasState createState() => _ListaCategoriasState();
}

class _ListaCategoriasState extends State<ListaCategorias> {
  @override
  void initState() {
    CartaService().loadCarta().then((result) {
      setState(() {
        //Carga del json con categorias y artículos
        miCarta = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Si aun no se ha cargado la carta.json local mostramos el CircularProgressIndicator
    if (miCarta.categorias == null) {
      return CircularProgressIndicator();
    } else {
      //Pongo Expanded porque al poner los dos ListView.builder en una columna daba error
      return Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: miCarta.categorias.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  categoriaSeleccionada =
                      miCarta.categorias[index].nombreCategoria;
                  articulos = miCarta.categorias[index].articulos;
                });
              },
              child: Container(
                width: 100,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                decoration: BoxDecoration(
                  color: (categoriaSeleccionada ==
                          miCarta.categorias[index].nombreCategoria)
                      ? Colors.indigo[200]
                      : Colors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      miCarta.categorias[index].nombreCategoria,
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}

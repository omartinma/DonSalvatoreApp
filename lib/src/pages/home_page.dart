import 'package:flutter/material.dart';
import 'package:flutter_don_salvatore/src/models/carta_model.dart';
import 'package:flutter_don_salvatore/src/services/carta_service.dart';

CartaModel miCarta = new CartaModel();
String categoriaSeleccionada = "";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    CartaService().loadCarta().then((result) {
      setState(() {
        miCarta = result;
      });
    });
    super.initState();
  }

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
  Widget build(BuildContext context) {
    // Si aun no se ha cargado al carta.json local mostramos el CircularProgressIndicator
    if (miCarta.categorias == null) {
      return CircularProgressIndicator();
    } else {
      return Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: miCarta.categorias.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                print(miCarta.categorias[index].nombreCategoria);
                setState(() {
                  categoriaSeleccionada =
                      miCarta.categorias[index].nombreCategoria;
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
                    Image.asset("assets/icon_pizza.png", height: 60.0),
                    //TODO: FALTA CARGAR COLOR DE CONTAINER Y PATH DE IMAGEN DESDE EL JSON
                    SizedBox(height: 5.0),
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

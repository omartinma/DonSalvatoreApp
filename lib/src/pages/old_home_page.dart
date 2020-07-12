import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_don_salvatore/src/models/carta_model.dart';
import 'package:flutter_don_salvatore/src/services/carta_service.dart';

CartaModel miCarta = new CartaModel();

String categoriaSeleccionada = "";
final String cartaCargada = new CartaService().cargarData();

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
            // If we need to rebuild the widget with the resulting data,
            // make sure to use `setState`
            //setState(() {
                //miCarta = result;
            //});
        });


    print("....mi print...");
    super.initState();
  }

//Future<CartaModel> cargaInitState() async {
  //return await CartaService
//}


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString("assets/carta.json"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text("No se han podido cargar las categorías");
        } else if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        // Tenemos los datos, cargamos la lista de categorias
        final List<dynamic> showData = json.decode(snapshot.data.toString());
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: showData.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print(showData[index]['nombreCategoria']);
                  setState(() {
                    categoriaSeleccionada = showData[index]['nombreCategoria'];
                  });
                },
                child: Container(
                  width: 100,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: (categoriaSeleccionada ==
                            showData[index]['nombreCategoria'])
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
                        showData[index]['nombreCategoria'],
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
      },
    );
  }
}

// No uso este Widget porque el SetState no em está funcionando al separar la lógica con él y no actualiza ListViweBuilder
class CajaCategoria extends StatefulWidget {
  final dynamic categoriaDatos;

  CajaCategoria(this.categoriaDatos);

  @override
  _CajaCategoriaState createState() => _CajaCategoriaState();
}

class _CajaCategoriaState extends State<CajaCategoria> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.categoriaDatos['nombreCategoria']);
        setState(() {
          categoriaSeleccionada = widget.categoriaDatos['nombreCategoria'];
        });
      },
      child: Container(
        width: 100,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        decoration: BoxDecoration(
          color: (categoriaSeleccionada ==
                  widget.categoriaDatos['nombreCategoria'])
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
              widget.categoriaDatos['nombreCategoria'],
              style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

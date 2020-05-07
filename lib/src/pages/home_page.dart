import 'package:flutter/material.dart';
import 'dart:convert';

String categoriaSeleccionada = "";

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ListaCategorias(),
            Container(
              height: MediaQuery.of(context).size.height - 150,
              
            ),
          ],
        ),
      ),
    );
  }
}

class ListaCategorias extends StatelessWidget {
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

        final List<dynamic> showData = json.decode(snapshot.data.toString());
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: showData.length,
            itemBuilder: (BuildContext context, int index) {
              return CajaCategoria(showData[index]);
            },
          ),
        );
      },
    );
  }
}

class CajaCategoria extends StatefulWidget {
  final dynamic categoriaDatos;

  const CajaCategoria(this.categoriaDatos);

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
        print("........" + widget.categoriaDatos['nombreCategoria']);
      },
      child: Container(
        width: 100,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        decoration: BoxDecoration(
          color: (categoriaSeleccionada == widget.categoriaDatos['nombreCategoria'])
              ? Colors.indigo[200]
              : Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
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



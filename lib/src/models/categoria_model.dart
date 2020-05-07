class Categoria {
  final String pathImage;
  final String nombre;
  final String color;

  Categoria(this.pathImage, this.nombre, this.color);
}

final List<Categoria> categorias = [
    Categoria("ensaladas.jpg", "Ensaladas", "0xffa76093"),
    Categoria("pizzas.jpg", "Pizzas", "0xffb99093"),
    Categoria("bocadillos.jpg", "Bocadillos", "0xffb74093"),
    Categoria("ensaladas.jpg", "Ensaladas", "0xffb70023"),
  ];
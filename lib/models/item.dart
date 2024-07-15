class Item {
  final int id;
  final String name;

  final double price;


  Item({
    required this.id,
    required this.name,

    required this.price,

  });
  // Méthode pour convertir un objet Item en Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,

    };
  }

}

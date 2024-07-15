import 'package:flutter/material.dart';
import 'package:food_app/animations/FadeAnimation.dart';
import 'package:food_app/cart_item.dart';
import 'package:food_app/cart_page.dart';
import 'package:food_app/database/database_helper.dart';
import 'package:food_app/models/item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfItemsInCart = 0;

  List<String> categories = ["Pizza", "Burgers", "Pasta", "Salad"];

  List<dynamic> pizzaFoods = [
    {"name": "Margherita Pizza", "price": "\$15.00","image": "assets/images/pizza1.jpeg", "isFavorite": false},
    {"name": "Pepperoni Pizza", "price": "\$17.00", "image": "assets/images/pizza2.jpg", "isFavorite": false},
    {"name": "Vegetarian Pizza", "price": "\$16.00","image": "assets/images/pizza3.jpg", "isFavorite": false},
  ];

  List<dynamic> burgerFoods = [
    {"name": "Beef Burger ", "price": "\$10.00","image": "assets/images/burger1.jpg", "isFavorite": false},
    {"name": "Chicken Burger", "price": "\$16.00","image": "assets/images/burger2.jpg", "isFavorite": false},
    {"name": "Healthy Burger", "price": "\$17.00","image": "assets/images/burger3.jpg", "isFavorite": false},

  ];


  List<dynamic> pastaFoods = [
    // Ajoutez des éléments de la liste de desserts
    {"name": "Chicken Pasta", "price": "\$7.00","image": "assets/images/pasta1.jpg", "isFavorite": false},
    {"name": "Seafood Pasta", "price": "\$12.00","image": "assets/images/pasta2.jpg", "isFavorite": false},
    {"name": "Cheese Pasta", "price": "\$18.00","image": "assets/images/pasta3.jpg", "isFavorite": false},
  ];

  List<dynamic> saladFoods = [
    {"name": "Caesar Salad", "price": "\$5.00","image": "assets/images/salad1.jpg", "isFavorite": false},
    {"name": "Healthy Salad", "price": "\$16.00","image": "assets/images/salad2.jpeg", "isFavorite": false},
    {"name": "Avocado Salad", "price": "\$20.00","image": "assets/images/salad3.jpg", "isFavorite": false},
  ];

  List<dynamic> currentCategoryFoods = []; // Déclaration de la variable
  List<CartItem> cartItems = []; // Déclaration de la liste pour le panier


  int selectedCategory = 0;


  @override
  Widget build(BuildContext context) {
    switch (selectedCategory) {
      case 0:
        currentCategoryFoods = pizzaFoods;
        break;
      case 1:
        currentCategoryFoods = burgerFoods;
        break;

      case 2:
        currentCategoryFoods = pastaFoods;
        break;
      case 3:
        currentCategoryFoods = saladFoods;
        break;
      default:
        currentCategoryFoods = [];
        break;
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: Icon(null),
        actions: <Widget>[
          FadeAnimation(
            1,
            IconButton(
              onPressed: () {
                double total = calculateTotal(); // Calcul du total
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(cartItems: cartItems, total: total),
                  ),
                );
              },
              icon: Icon(Icons.shopping_basket, color: Colors.grey[800]),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      'Food Delivery',
                      style: TextStyle(
                        color: Colors.grey[80],
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) =>
                          FadeAnimation(1, makeCategory(
                              title: categories[index], index: index)),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            FadeAnimation(
              1,
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Free Delivery',
                  style: TextStyle(color: Colors.grey[700],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: currentCategoryFoods.length,
                  itemBuilder: (context, index) =>
                      FadeAnimation(1, makeItem(
                          image: currentCategoryFoods[index]["image"],
                          isFavorite: currentCategoryFoods[index]["isFavorite"],
                          index: index)),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget makeCategory({title, index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = index;
        });
      },
      child: AnimatedContainer(
        width: 120,
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: selectedCategory == index ? Colors.yellow[700] : Colors
              .grey[300],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: selectedCategory == index ? Colors.black : Colors
                  .grey[700],
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget makeItem({image, isFavorite, index}) {
    String itemName = currentCategoryFoods[index]["name"]; // Obtenez le nom de l'article
    String itemPrice = currentCategoryFoods[index]["price"];

    return AspectRatio(
      aspectRatio: 1 / 1.5,
      child: GestureDetector(
        onTap: () {
          // Gérer le tap sur l'article si nécessaire
        },

        child: Container(
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                stops: [.2, .9],
                colors: [
                  Colors.black.withOpacity(.9),
                  Colors.black.withOpacity(.3),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentCategoryFoods[index]["isFavorite"] =
                        !currentCategoryFoods[index]["isFavorite"];
                      });
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1.5,
                              color: isFavorite ? Colors.red : Colors
                                  .transparent),
                        ),
                        child: isFavorite ? Icon(Icons.favorite, color: Colors
                            .red) : Icon(Icons.favorite, color: Colors.white),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        itemPrice, // Affichez le prix de l'article
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        itemName, // Affichez le nom de l'article
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Ajouter l'article au panier lorsque le bouton est pressé
                          addToCart(currentCategoryFoods[index]);
                        },
                        child: Text('Ajouter au panier'),
                      ),


                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void addToCart(dynamic foodItem) {
    // Créer un objet CartItem à partir de foodItem
    CartItem cartItem = CartItem(
      name: foodItem['name'],
      price: double.parse(foodItem['price'].replaceAll('\$', '')),
      quantity: 1, // Nous ajoutons un seul article pour l'instant
    );

    // Ajouter cet objet à la liste du panier
    cartItems.add(cartItem);
    // Ajouter l'article à la base de données
    addItemToDatabase(cartItem);

    // Mettre à jour l'affichage du nombre d'articles dans le panier
    setState(() {
      numberOfItemsInCart = cartItems.length;
    });
  }

  void addItemToDatabase(CartItem cartItem) async {
    try {
      // Créer un nouvel objet Item à partir de CartItem
      Item newItem = Item(
        id: cartItem.hashCode, // Vous pouvez définir l'ID comme vous le souhaitez
        name: cartItem.name,
        price: cartItem.price,
      );

      // Ajouter cet élément à la base de données
      await DatabaseHelper().addItem(newItem);
      print('Item added to database successfully');
    } catch (e) {
      print('Failed to add item to database: $e');
    }
  }
  double calculateTotal() {
    double total = 0.0;

    for (CartItem item in cartItems) {
      total += item.price * item.quantity;
    }

    return total;
  }


}


import 'package:my_thai_star_flutter/models/dish.dart';

class DummyData {
  static final List<Dish> dishes = [
    Dish(
      name: "THAI GREEN CHICKEN CURRY",
      description: "Master this aromatic, creamy & extremely tasty" +
          " chicken Thai green curry recipe from Jamie Oliver & treat" +
          " yourself to an authentic taste of South East Asia.",
      price: 14.75,
      assetImage: "assets/images/green-curry.jpg",
      extras: {
        "Tofu": false,
        "Extra Curry": false,
      },
      comment: "",
    ),
    Dish(
      name: "THAI SPICY BASIL FRIED RICE",
      description: "This is a staple of Thai cooking. " +
          "Adjust the spices to your own tastes for a really " +
          "great use for leftover rice!! I get the basil from a " +
          "local Asian market. It has a different flavor than " +
          "that of regular basil and makes all the difference " +
          "in this recipe. It is fast and fairly easy to make, " +
          "but requires constant stirring",
      price: 12.99,
      assetImage: "assets/images/basil-fried.jpg",
      extras: {
        "Tofu": false,
        "Extra Curry": false,
      },
      comment: "",
    ),
  ];

  static String bookingNumber = "CB_20191129_ffcc0c387c07db666026a1c218a8479a";
}
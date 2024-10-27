import 'package:collection/collection.dart';
import 'package:fooddeliveryapp/models/cart_item.dart';
import 'package:intl/intl.dart';

import 'food.dart';
import 'package:flutter/material.dart';

class Restaurant extends ChangeNotifier{
  // Define a private field _menu
  final List<Food> _menu = [
    Food(
      name: "Classic Cheeseburger",
      description:
          "A juicy beef patty with melted cheddar, lettuce, tomato, and a hint of onion and pickle.",
      imagePath: "lib/Images/cheese_burger.png",
      price: 8.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra Cheese", price: 0.99),
        Addon(name: "Bacon", price: 1.49),
        Addon(name: "Avocado", price: 1.99),
      ],
    ),
    Food(
      name: "BBQ Bacon Burger",
      description:
          "Smoky BBQ sauce, crispy bacon, and onion rings make this beef burger a savory delight.",
      imagePath: "lib/Images/bbq_burger.png",
      price: 10.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Grilled Onions", price: 0.99),
        Addon(name: "Jalapeños", price: 1.49),
        Addon(name: "Extra BBQ Sauce", price: 1.99),
      ],
    ),
    Food(
      name: "Aloha Burger",
      description:
          "A tropical twist with pineapple, teriyaki sauce, and a juicy beef patty topped with melted cheese.",
      imagePath: "lib/Images/aloha_burger.png",
      price: 9.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra Pineapple", price: 0.99),
        Addon(name: "Teriyaki Sauce", price: 1.49),
      ],
    ),
    Food(
      name: "Blue Moon Burger",
      description:
          "A rich blend of blue cheese, caramelized onions, and a premium beef patty for gourmet taste.",
      imagePath: "lib/Images/bluemoon_burger.png",
      price: 11.49,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra Blue Cheese", price: 1.49),
        Addon(name: "Caramelized Onions", price: 0.99),
      ],
    ),
    Food(
      name: "Veggie Burger",
      description:
          "A hearty veggie patty topped with fresh lettuce, tomatoes, and vegan cheese for a delicious meat-free option.",
      imagePath: "lib/Images/vege_burger.png",
      price: 7.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra Vegan Cheese", price: 0.99),
        Addon(name: "Avocado", price: 1.49),
      ],
    ),
  ];

  List<Food> get menu => _menu;

  // User cart
final List<CartItem> _cart = [];
List<CartItem> get cart => _cart;


// Add to cart
void addToCart(Food food, List<Addon> selectedAddons) {
  // See if there is a cart item already with the same food and selected addons
  CartItem? cartItem = _cart.firstWhereOrNull((item) {
    // Check if the food items are the same
    bool isSameFood = item.food == food;

    // Check if the list of selected addons are the same
    bool isSameAddons = const ListEquality().equals(item.selectedAddons, selectedAddons);

    return isSameFood && isSameAddons;
  });

  if (cartItem != null) {
    // If an item with the same food and addons exists, increase its quantity
    cartItem.quantity += 1;
  } else {
    // If it doesn't exist, create a new CartItem and add it to the cart
    _cart.add(CartItem(food: food, selectedAddons: selectedAddons));
  }
  notifyListeners();
}

// Remove from cart
void removeFromCart(CartItem cartItem) {
  int cartIndex = _cart.indexOf(cartItem);

  if (cartIndex != -1) {
    if (_cart[cartIndex].quantity > 1) {
      _cart[cartIndex].quantity--;
    } else {
      _cart.removeAt(cartIndex);
    }
  }
  notifyListeners();
}

// Get total number of items in cart
int getTotalItemCount() {
  int totalItemCount = 0;

  for (CartItem cartItem in _cart) {
    totalItemCount += cartItem.quantity;
  }

  return totalItemCount;
}

// Clear cart
void clearCart() {
  _cart.clear();
  notifyListeners();
}

// Get total price of cart
double getTotalPrice() {
  double total = 0.0;

  for (CartItem cartItem in _cart) {
    double itemTotal = cartItem.food.price;

    for (Addon addon in cartItem.selectedAddons) {
      itemTotal += addon.price;
    }

    total += itemTotal * cartItem.quantity;
  }

  return total;
}

String displayCartReceipt() {
  final receipt = StringBuffer();
  receipt.writeln("Here's your receipt:");
  receipt.writeln();

  // Format the date to include up to seconds only
  String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  receipt.writeln(formattedDate);
  receipt.writeln();
  receipt.writeln("--------------");

  for (final cartItem in _cart) {
    receipt.writeln(
      "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}"
    );
    if (cartItem.selectedAddons.isNotEmpty) {
      receipt.writeln("   Add-ons: ${_formatAddons(cartItem.selectedAddons)}");
    }
    receipt.writeln();
  }

  receipt.writeln("--------------");
  receipt.writeln();
  receipt.writeln("Total Items: ${getTotalItemCount()}");
  receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");

  return receipt.toString();
}

// Format double value into money
String _formatPrice(double price) {
  return "\$${price.toStringAsFixed(2)}";
}

// Format list of addons into a string summary
String _formatAddons(List<Addon> addons) {
  return addons
      .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
      .join(", ");
}








}

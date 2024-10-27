import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/components/my_button.dart';
import 'package:fooddeliveryapp/components/my_cart_tile.dart';
import 'package:fooddeliveryapp/models/restaurant.dart';
import 'package:fooddeliveryapp/pages/delivery_progress_page.dart';
import 'package:fooddeliveryapp/pages/payment_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        // Cart
        final userCart = restaurant.cart;

        // Scaffold UI
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
          ),
          body: Column(
            children: [
              Expanded(
                child: userCart.isEmpty
                    ? const Center(
                        child: Text("Cart is empty.."),
                      )
                    : ListView.builder(
                        itemCount: userCart.length,
                        itemBuilder: (context, index) {
                          // Get individual cart item
                          final cartItem = userCart[index];

                          // Return cart tile UI
                          return MyCartTile(cartItem: cartItem);
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyButton(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentPage()),),
                  text: "Go to checkout",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

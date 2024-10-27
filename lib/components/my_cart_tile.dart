import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/components/my_quantity_selector.dart';
import 'package:fooddeliveryapp/models/cart_item.dart';
import 'package:fooddeliveryapp/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;

  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) => Container(
        child: Column(
          children: [
            Row(
              children: [
                // Food image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    cartItem.food.imagePath,
                    height: 100,
                    width: 100,
                  ),
                ),

                const SizedBox(width: 10),

                // Name and price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Food name
                    Text(cartItem.food.name),

                    // Food price
                    Text('\$${cartItem.food.price.toString()}'),
                  ],
                ),
                QuantitySelector(
                    quantity: cartItem.quantity,
                    food: cartItem.food,
                    onDecrement: () {
                      restaurant.removeFromCart(cartItem);
                    },
                    onIncrement: () {
                      restaurant.addToCart(
                        cartItem.food, cartItem.selectedAddons
                      );
                    },
                  ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

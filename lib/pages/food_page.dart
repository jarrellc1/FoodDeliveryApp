import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/components/my_button.dart';
import 'package:fooddeliveryapp/models/food.dart';
import 'package:fooddeliveryapp/models/restaurant.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddons = {};

  FoodPage({
    super.key,
    required this.food,
  }){
    for (Addon addon in food.availableAddons) {
      selectedAddons[addon] = false;
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {

  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    Navigator.pop(context);
  List<Addon> currentlySelectedAddons = [];

  for (Addon addon in widget.food.availableAddons) {
    if (widget.selectedAddons[addon] == true) {
      currentlySelectedAddons.add(addon);
    }
  }

  context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Food image
            Image.asset(widget.food.imagePath),

            // Food name
            Text(
              widget.food.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            // Food description
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.food.description),
            ),

            // Addons
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.food.availableAddons.length,
              itemBuilder: (context, index) {
                // Get individual addon
                Addon addon = widget.food.availableAddons[index];

                // Return check box UI
                return CheckboxListTile(
                  title: Text(addon.name),
                  subtitle: Text('\$${addon.price.toStringAsFixed(2)}'),
                  value: widget.selectedAddons[addon],
                  onChanged: (bool? value) {
                    setState(() {
                      widget.selectedAddons[addon] = value!;
                    });
                  },
                );
              },
            ),

            // Button -> add to cart (implemented with MyButton)
            MyButton(
              onTap: () => addToCart(widget.food,  widget.selectedAddons),
              text: "Add to Cart",
            ),
          ],
        ),
      ),
    );
  }
}

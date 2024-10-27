import 'package:fooddeliveryapp/models/food.dart';
import 'package:flutter/material.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;

  const FoodTile({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              // Text food details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(food.name),
                    Text('\$${food.price}'),
                    Text(food.description),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              // Food image

              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(food.imagePath, height: 120)),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.tertiary,
          endIndent:25,
          indent: 25,
        )
      ],
    );
  }
}

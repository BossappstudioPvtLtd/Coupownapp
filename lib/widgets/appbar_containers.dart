import 'package:coupown/components/small_sutton.dart';
import 'package:flutter/material.dart';

class AppbarContainers extends StatelessWidget {
  const AppbarContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        // Align the container in the center horizontally
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, size: 30),
          Row(
            children: [
              SmallButton(
                containerheight: 35,
                containerwidth: 100,
                onPressed: () {
                  // Add your subscription logic here
                },
                elevationsize: 8,
                text: 'Subscribe',
              ),
              const Icon(Icons.notifications_none, size: 27),
              const SizedBox(width: 10),
              const Icon(Icons.favorite_border, size: 27),
              const SizedBox(width: 10),
              const Icon(Icons.location_on_outlined, size: 27),
            ],
          ),
        ],
      ),
    );
  }
}

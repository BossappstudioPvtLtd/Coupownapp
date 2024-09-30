import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/subscription/payment_methord.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _ScrollableCardsState();
}

class _ScrollableCardsState extends State<PlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorPrimary,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: MyAppbar(text: "Pick Your Plan"),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal, // Horizontal scrolling
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCard(
                  "STARTER",
                  "199",
                  "A great business development plan for beginners",
                  Icons.telegram, // Person icon
                  onAddToCart: () {
                    _onAddToCart("STARTER");
                  },
                ),
                const SizedBox(width: 20), // Space between cards
                _buildCard(
                  "PRO",
                  "499",
                  "Advanced tools and support for growing businesses",
                  Icons.rocket, // Rocket icon
                  onAddToCart: () {
                    _onAddToCart("PRO");
                  },
                ),
                const SizedBox(width: 20), // Space between cards
                _buildCard(
                  "ENTERPRISE",
                  "999",
                  "Full suite with custom solutions for large enterprises",
                  Icons.warehouse_sharp, // Warehouse icon
                  onAddToCart: () {
                    _onAddToCart("ENTERPRISE");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // A helper method to build each card.
  Widget _buildCard(String title, String price, String description, IconData icon, {required Function() onAddToCart}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70),
      child: Container(
        width: 300, // Adjust width as needed
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: appColorPrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 2, color: appColorAccent),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Textedit(text: title),
            Icon(icon, size: 50, color: appColorAccent), // Icon added here
            const SizedBox(height: 10),
            Textedit(text: description),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Textedit(text: "₹"),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 50, // Increase font size
                    color: appColorAccent, // Change text color (use your preferred color)
                    fontWeight: FontWeight.bold, // Optional: Make the text bold
                  ),
                ),
                const Textedit(text: "/Month"),
              ],
            ),
            const SizedBox(height: 30),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Textedit(text: "* Plan includes key features for this level", fontSize: 11),
                Textedit(text: "* High-quality support", fontSize: 11),
                Textedit(text: "* Access to exclusive resources", fontSize: 11),
                Textedit(text: "* Flexible upgrade options", fontSize: 11),
              ],
            ),
            const Spacer(),
            MyButtonAni(
            
              elevationsize: 20,
              text: "Add to cart",
              fontSize: 16,
             // onTap: onAddToCart, // Pass the function to handle button tap
             onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>const PaymentMethodPage()));},
            ),
          ],
        ),
      ),
    );
  }

  void _onAddToCart(String plan) {
    // Handle the add to cart logic
    print("Added $plan plan to cart");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$plan plan added to cart')),
    );
  }
}

import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/scheduler.dart';

class MyRowWidget1 extends StatelessWidget {
  const MyRowWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width using MediaQuery
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Existing Textedit widget
          const Textedit(
            text: 'All Featured',
            fontWeight: FontWeight.bold,
          ),
          
          // Adjust the layout for small screens
          if (screenWidth > 60) ...[
            // For larger screens, show buttons in a row
            Row(
              children: [
                // Short button with icon
                _buildButton(
                  icon: Icons.sort,
                  label: 'Short',
                  onPressed: () {
                    // Handle the short button press here
                    print('Short button pressed');
                  },
                ),
                const SizedBox(width: 8), // Add spacing between buttons
                // Filter button with icon
                _buildButton(
                  icon: Icons.filter_list,
                  label: 'Filter',
                  onPressed: () {
                    // Handle the filter button press here
                    print('Filter button pressed');
                  },
                ),
              ],
            ),
          ] else ...[
            // For smaller screens, stack buttons vertically
            Column(
              children: [
                _buildButton(
                  icon: Icons.sort,
                  label: 'Short',
                  onPressed: () {
                    // Handle the short button press here
                    print('Short button pressed');
                  },
                ),
                const SizedBox(height: 8), // Add spacing between buttons
                _buildButton(
                  icon: Icons.filter_list,
                  label: 'Filter',
                  onPressed: () {
                    // Handle the filter button press here
                    print('Filter button pressed');
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // Helper method to build the buttons with scale animation
  Widget _buildButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(
          parent: AnimationController(
            duration: const Duration(milliseconds: 600),
            vsync: TestVSync(), // Replace with your TickerProvider
          )..repeat(reverse: true),
          curve: Curves.easeInOut,
        ),
      ),
      child: Card(
        color: appColorPrimary,
        child: TextButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: appTextColorSecondary, size: 20),
          label: Textedit(
            text: label,
            fontSize: 8,
          ),
        ),
      ),
    );
  }
}

// Dummy TickerProvider for the animation controller
class TestVSync extends TickerProvider {
  @override
  Ticker createTicker(onTick) => Ticker(onTick);
}

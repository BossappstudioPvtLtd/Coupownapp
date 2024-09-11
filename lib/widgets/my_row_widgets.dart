import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:scale_button/scale_button.dart'; // Import scale_button package
import 'package:coupown/components/text_edit.dart';

class MyRowWidget extends StatelessWidget {
  const MyRowWidget({super.key});

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
          if (screenWidth > 600) ...[
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
            Row(
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
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ScaleButton(
        duration: const Duration(milliseconds: 100),
        onTap: onPressed,
        child: Material(
          borderRadius: BorderRadius.circular(8),
          elevation: 5,
          color: appColorPrimary,
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton.icon(
              onPressed: () {}, // Handle onPressed event through ScaleButton
              icon: Icon(icon, color: appTextColorSecondary, size: 20),
              label: Textedit(
                text: label,
                fontSize: 8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

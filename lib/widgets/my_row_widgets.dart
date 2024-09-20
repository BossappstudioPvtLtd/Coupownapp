import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:scale_button/scale_button.dart'; // Import scale_button package
import 'package:coupown/components/text_edit.dart';

class MyRowWidget extends StatefulWidget {
  const MyRowWidget({super.key});

  @override
  _MyRowWidgetState createState() => _MyRowWidgetState();
}

class _MyRowWidgetState extends State<MyRowWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration of 2 seconds
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Define the fade-in animation from opacity 0.2 to 1.0
    _fadeInAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Define the slide-in animation from below the screen to its final position
    _slideInAnimation = Tween<Offset>(begin: const Offset(0, 2.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation when the widget is initialized
    _controller.forward();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is destroyed to free resources
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width using MediaQuery
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: FadeTransition(
        opacity: _fadeInAnimation, // Apply fade-in animation
        child: SlideTransition(
          position: _slideInAnimation, // Apply slide-in animation
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
        ),
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

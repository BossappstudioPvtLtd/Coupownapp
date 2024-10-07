

import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/price_bar.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:coupown/widgets/category.dart';
import 'package:coupown/widgets/listilecard.dart';
import 'package:flutter/material.dart';
import 'package:scale_button/scale_button.dart'; // Import scale_button package
import 'package:coupown/components/text_edit.dart';

class MyRowWidget extends StatefulWidget {
  const MyRowWidget({super.key});

  @override
  _MyRowWidgetState createState() => _MyRowWidgetState();
}

class _MyRowWidgetState extends State<MyRowWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration of 2 seconds
    _controller = AnimationController(
      duration: const Duration(seconds: 0),
      vsync: this,
    );

    // Define the fade-in animation from opacity 0.2 to 1.0
    _fadeInAnimation = Tween<double>(begin: 0.5, end: 5.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Define the slide-in animation from below the screen to its final position
    _slideInAnimation =
        Tween<Offset>(begin: const Offset(0, 2.0), end: Offset.zero).animate(
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
        _showSortBySheet(context);
        print('Short button pressed');
      },
    ),
    const SizedBox(width: 8), // Correcting the spacing between buttons
    _buildButton(
      icon: Icons.filter_list,
      label: 'Filter',
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: const Color.fromARGB(255, 242, 243, 255),
          context: context,
          isScrollControlled: true, // This allows the bottom sheet to take full height
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.8, // Set to 1.0 for full height
              minChildSize: 0.5, // Minimum height when sheet is minimized
              maxChildSize: 1.0, // Maximum height for the sheet
              builder: (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.9, // Set desired height
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 150),
                          child: Divider(thickness: 3, color: Color.fromARGB(187, 205, 205, 205)),
                        ),
                        // Filter Header with Close Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            SizedBox(
                              width: 190,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Filter',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        // ListTile Category with Trailing View and Forward Arrow
                        Card(
                          color: appColorPrimary,
                          child: Column(
                            children: [
                              Listilecard(
                                text: 'Category',
                                onTap: () {
                                  showCategorysheet(context);
                              //Navigator.pop(context); // Close bottom sheet after selection
                                },
                              ),
                              const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Divider()),
                              Listilecard(
                                text: 'Services',
                                onTap: () {
                                  showServicesSheet(context);
                                 // Navigator.pop(context); // Close bottom sheet after selection
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Card(
                          color: appColorPrimary,
                          child: Listilecard(
                            text: 'Status',
                            onTap: () {
                              showStausSheet(context);
                         //Navigator.pop(context); // Close bottom sheet after selection
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        const PriceIncreaseBar(),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
        
      },
    ),
  ],
)

              ],
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build the buttons with scale animation
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
        onTap: onPressed, // Use the onTap from ScaleButton
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
              icon: Icon(icon, color: appTextColorSecondary, size: 20),
              label: Textedit(
                text: label,
              color: appTextColorPrimary,
              fontWeight: FontWeight.bold,
                fontSize: 8,
              ),
              // Remove the onPressed from TextButton.icon
              onPressed: null, // Set to null to avoid conflicts
            ),
          ),
        ),
      ),
    );
  }
}





 void _showSortBySheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: appColorPrimary,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_outlined), // Back button icon
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 8), // Add some spacing between the icon and text
                const Text(
                  'Sort by', // Corrected "Short by" to "Sort by"
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text('Date', style: TextStyle(fontWeight: FontWeight.bold)), // Bold text for the option
              onTap: () {
                // Handle date selection
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart), // Changed to bar graph icon
              title: const Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)), // Bold text for the option
              trailing: const Row(
                mainAxisSize: MainAxisSize.min, // Use min size for the row
                children: [
                  Text('Low to High', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)), // Adjust the color as needed
                  Icon(Icons.arrow_upward_rounded,color:Colors.blueGrey,), // Retaining the upward arrow icon
                ],
              ),
              onTap: () {
                // Handle amount selection
              },
            ),
           SmallButton(meterialColor: appColorAccent,elevationsize: 20, text: "Apply", containerheight: 40,containerwidth: 400,onTap:(){Navigator.pop(context); } ,)
 
          ],
        ),
      );
    },
  );
}






void showCategorysheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: const Color.fromARGB(255, 242, 243, 255),
    context: context,
    isScrollControlled: true, // This allows the bottom sheet to take full height
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8, // Set to 1.0 for full height
        minChildSize: 0.5, // Minimum height when sheet is minimized
        maxChildSize: 1.0, // Maximum height for the sheet
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController, // Connect the scroll controller
            child: const Padding(
              padding: EdgeInsets.all(16.0), // Add padding for content
              child: Column(
                children: <Widget>[
                  Category(), // Replace with your custom widget
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

void showServicesSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: const Color.fromARGB(255, 242, 243, 255),
    context: context,
    isScrollControlled: true, // This allows the bottom sheet to take full height
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8, // Set to 1.0 for full height
        minChildSize: 0.5, // Minimum height when sheet is minimized
        maxChildSize: 1.0, // Maximum height for the sheet
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController, // Connect the scroll controller
            child: const Padding(
              padding: EdgeInsets.all(16.0), // Add padding for content
              child: Column(
                children: <Widget>[
                  Category(), // Replace with your custom widget
                ],
              ),
            ),
          );
        },
      );
    },
  );
}


void showStausSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: const Color.fromARGB(255, 242, 243, 255),
    context: context,
    isScrollControlled: true, // This allows the bottom sheet to take full height
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8, // Set to 1.0 for full height
        minChildSize: 0.5, // Minimum height when sheet is minimized
        maxChildSize: 1.0, // Maximum height for the sheet
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController, // Connect the scroll controller
            child: const Padding(
              padding: EdgeInsets.all(16.0), // Add padding for content
              child: Column(
                children: <Widget>[
                  Category(), // Replace with your custom widget
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

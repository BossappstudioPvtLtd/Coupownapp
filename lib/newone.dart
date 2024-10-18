import 'package:coupown/Const/appwidget.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:coupown/components/splash_radius.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';
import 'package:coupown/Const/app_colors.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:scale_button/scale_button.dart';

class CircleAvatarRadiusControl extends StatefulWidget {
  const CircleAvatarRadiusControl({super.key});

  @override
  _CircleAvatarRadiusControlState createState() =>
      _CircleAvatarRadiusControlState();
}

class _CircleAvatarRadiusControlState extends State<CircleAvatarRadiusControl> {
  double _scale = 1.0; // Initial scale for the background image
  int _count = 15; // Start with a higher value to represent the initial zoom level (assuming this is the default zoom level)

  // Function to show a message when limits are reached
  void _showLimitMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black87,
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Function to zoom in the background image (now reduces the scale and decreases the count)
 void _zoomIn() {
  if (_count < 15) { // Ensure the zoom doesn't go above 15
    setState(() {
      _scale -= 0.1; // Decrease the scale to "zoom out"
      _count++; // Increase the count number (show larger value on zoom in)
    });
  } else {
    _showLimitMessage("Maximum radius level reached!"); // Show message when limit is reached
  }
}

// Function to zoom out (increases the scale and decreases the count)
void _zoomOut() {
  if (_count > 1) { // Ensure the zoom doesn't exceed 1
    setState(() {
      _scale += 0.1; // Increase the scale to "zoom in"
      _count--; // Decrease the count number (show smaller value on zoom out)
    });
  } else {
    _showLimitMessage("Minimum radius level reached!"); // Show message when limit is reached
  }
}


  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    return Stack(
      children: [
        
        Stack(
          children: [
            Positioned.fill(
              child: Transform.scale(
                scale: _scale, // Use the scale variable to zoom in/out
                child: Image.asset(
                  "assets/avatar/app.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  Spacer(),
                  Container(
                    child: _buildButton(
                          icon: Icons.sort,
                          label: 'Short',
                          onPressed: () {
                            _showSortBySheet(context);
                            print('Short button pressed');
                          },
                        ),
                  ),
                ],
              ),
            ),
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut, // Smooth transition curve
                width: 400 - (50 * (_scale - 1)), // Adjust width based on scale
                height: 400 - (50 * (_scale - 1)), // Adjust height based on scale
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white38),
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Colors.white10, Colors.white10],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: SpalshRipple(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 200),
              child: Center(
                child: ClipPath(
                  clipper: MessageClipper(borderRadius: 4),
                  child: Stack(
                    children: [
                      Container(
                        height: 40 + (10 * (_scale - 1)),
                        width: 30 + (10 * (_scale - 1)),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.white38,
                        ),
                      ),
                      Container(
                        height: 30 + (10 * (_scale - 1)),
                        width: 30 + (10 * (_scale - 1)),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Center(
                          child: Text(
                            "Message",
                            style: TextStyle(
                              color: appColorAccent,
                              fontSize: 12 + (2 * (_scale - 1)),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
              child: Material(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(500),
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Zoom Out IconButton
                      IconButton(
                        onPressed: _zoomOut,
                        icon: const Icon(Icons.remove, size: 30),
                        color: appColorAccent,
                      ),
                      const SizedBox(width: 10),
                      Material(
                        color: Colors.white12,
                        elevation: 5,
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          child: Column(
                            children: [
                              Text(
                                "$_count", // Display the count dynamically
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: appColorAccent,
                                ),
                              ),
                              const Text(
                                "KM",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: appColorAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Zoom In IconButton
                      IconButton(
                        onPressed: _zoomIn,
                        icon: const Icon(Icons.add, size: 30),
                        color: appColorAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
          color:Colors.white38,
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton.icon(
              icon: Icon(icon, color: appColorPrimary, size: 20),
              label: Textedit(
                text: label,
              color: appColorPrimary,
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

void _showSortBySheet(BuildContext context) {
   int? _selectedOption = 0; // 0 for Rate Wise, 1 for Distance Wise

  showModalBottomSheet(
    backgroundColor:appColorPrimary,
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
                  icon: const Icon(Icons.arrow_back_ios_outlined,color: appTextColorPrimary), // Back button icon
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 8), // Add some spacing between the icon and text
                const Text(
                  'Sort by', // Corrected "Short by" to "Sort by"
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: appTextColorPrimary),
                ),
              ],
            ),
            const SizedBox(height: 16),
           
            
             ListTile(
          leading: const Icon(Icons.money, color: appTextColorPrimary), // Rate icon
          title: const Text('Rate Wise', style: TextStyle(fontWeight: FontWeight.bold, color: appTextColorPrimary)),
          trailing: Radio<int>(
            focusColor: appColorAccent,
            hoverColor: appColorAccent,
            
            activeColor: appColorAccent,
            value: 0,
            groupValue: _selectedOption,
            onChanged: (int? value) {
             
                _selectedOption = value;
              
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.location_on, color: appTextColorPrimary), // Distance icon
          title: const Text('Distance Wise', style: TextStyle(fontWeight: FontWeight.bold, color: appTextColorPrimary)),
          trailing: Radio<int>(
            activeColor: appColorAccent,
            focusColor: appColorAccent,
            hoverColor: appColorAccent,
            value: 1,
            groupValue: _selectedOption,
            onChanged: (int? value) {
             
                _selectedOption = value;
              
            },
          ),
        ),
        const SizedBox(height: 16),
        SmallButton(
          meterialColor: appColorAccent,
          elevationsize: 20,
          text: "Apply",
          containerheight: 40,
          containerwidth: 400,
          onTap: () {
            // Handle apply action based on selected option
            if (_selectedOption == 0) {
              // Handle rate-wise sorting
              print("Rate Wise selected");
            } else if (_selectedOption == 1) {
              // Handle distance-wise sorting
              print("Distance Wise selected");
            }
            Navigator.pop(context);
          },
        ),
          ],
        ),
      );
    },
  );
}

import 'package:flutter/material.dart';

class MyIcons extends StatefulWidget {
  final void Function()? onTap;
  final IconData? icon;
  final Color? color;
  const MyIcons({super.key, this.onTap, this.icon, this.color});

  @override
  State<MyIcons> createState() => _MyIconsState();
}

class _MyIconsState extends State<MyIcons> {
  
  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
  
    return   InkWell(
  onTap: widget.onTap,
  borderRadius: BorderRadius.circular(24), // Optional, to define a rounded splash area
  splashColor: Colors.grey.withOpacity(0.5), // Optional, splash color
  child: Padding( padding: const EdgeInsets.all(8.0), // Add padding around the icon for better touch area
  child: Icon(widget.icon,color:widget.color ,size: screenWidth > 350 ? 20 : 24, // Smaller for small screens
    ),
  ),
);
  }
}

import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';

class MyAppbar extends StatefulWidget {
  final String text;
  const MyAppbar({super.key, required this.text});

  @override
  State<MyAppbar> createState() => _MyAppbarState();
}

class _MyAppbarState extends State<MyAppbar> {
  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    return  Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 20),
                child: Row(
                  children: [
                    Material(
                      color: const Color.fromARGB(245, 237, 247, 251),
                      borderRadius: BorderRadius.circular(50),
                      elevation: 5,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                        iconSize: isSmallScreen ? 20 : 24,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Textedit(
                        text:widget. text,
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 18 : 24,
                      ),
                    ),
                  ],
                ),
              );
  }
}
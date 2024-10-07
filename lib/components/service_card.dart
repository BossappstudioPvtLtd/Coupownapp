import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';

class SserviceCard extends StatefulWidget {
  final String text;
  final String text1;
  final void Function()? onTap;

  const SserviceCard({
    super.key,
    required this.text,
    required this.text1,
    this.onTap,
  });

  @override
  State<SserviceCard> createState() => _SserviceCardState();
}

class _SserviceCardState extends State<SserviceCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Material(
        color: Colors.transparent, // Makes the Material widget transparent
        child: InkWell(
          onTap: widget.onTap,
          splashColor: appColorAccent,
          borderRadius: BorderRadius.circular(8), // Ensures the splash is rounded
          child: Container(
            height: 80,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromARGB(255, 220, 220, 220),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.text,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.text1,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

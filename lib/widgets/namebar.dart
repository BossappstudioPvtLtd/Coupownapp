import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';
import 'package:scale_button/scale_button.dart';  // Import scale_button package

class Namebar extends StatefulWidget {
  final String text;
  final Color? color;
  final IconData? icon;
  final BoxBorder? border;
  final String nametext;
  final void Function()? onTap;
  final double? iconsize;
  final Color? iconcolor;
  const Namebar({super.key, required this.text, this.color, this.icon, this.border, this.onTap, this.iconsize, this.iconcolor, required this.nametext});

  @override
  State<Namebar> createState() => _NamebarState();
}
class _NamebarState extends State<Namebar> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 350; 

    return Padding( padding: EdgeInsets.symmetric( horizontal: isSmallScreen ? 8 : 15, vertical: isSmallScreen ? 5 : 10,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [ Textedit(text:widget.nametext,fontWeight: FontWeight.bold,),
          ScaleButton( duration: const Duration(milliseconds: 200),  bound: 0.1,  
            onTap:widget.onTap,child: Material( elevation: 5,child: Container(decoration: BoxDecoration(color: appColorPrimary,border: widget.border,),
              child: Padding( padding: EdgeInsets.symmetric( horizontal: isSmallScreen ? 2 : 4, vertical: isSmallScreen ? 1 : 2,),
                child:  Row( children: [ Textedit( text: widget.text, color: widget.color,  fontSize: 12, fontWeight: FontWeight.bold, ),
                  Icon(widget.icon, size: widget.iconsize, color: widget.iconcolor,
                    ),
                   ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:scale_button/scale_button.dart';

class SmallButton extends StatefulWidget {
  final Color? textcolor;
  final Color? meterialColor;
  final double? containerheight;
  final double? containerwidth;
  final double elevationsize;
  final void Function()? onTap;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onPressed;
  final String text;
  final double? fontSize;
  final FontWeight? textweight;
  final IconData? icon;
  final Color? iconcolor;
  final double? size;

  const SmallButton({
    super.key,
    this.meterialColor,
    this.onTap,
    this.containerheight,
    required this.elevationsize,
    this.borderRadius,
    required this.text,
    this.fontSize,
    this.textcolor,
    this.containerwidth,
    this.textweight,
    this.onPressed, this.icon, this.iconcolor, this.size,
  });

  @override
  State<SmallButton> createState() => _SmallButtonState();
}

class _SmallButtonState extends State<SmallButton> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
   // final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 600; // Define small screen

    return ScaleButton(
      duration: const Duration(milliseconds: 200),
      bound: 0.1,
      onTap: widget.onTap,
      
      
        child: Material(
          color: widget.meterialColor ?? appColorAccent,
          elevation: widget.elevationsize,
          borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(32)),
          child: SizedBox(
            height: widget.containerheight ,
            width: widget.containerwidth ,
            child: Center(
              child: Row(
                children: [
                  Icon(widget.icon,color: widget.iconcolor,size: widget.size,),
                  SizedBox(width: 5,),
                  Center(
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: widget.fontSize ?? (isSmallScreen ? 14 : 17),
                        fontWeight: widget.textweight ?? FontWeight.bold,
                        color: widget.textcolor ?? appColorPrimaryLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    
    );
  }
}

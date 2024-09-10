import 'package:flutter/material.dart';

class Textedit extends StatefulWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  const Textedit({
    super.key,
    this.color,
    required this.text,
    this.fontSize,
    this.fontWeight,
  });

  @override
  State<Textedit> createState() => _TexteditState();
}

class _TexteditState extends State<Textedit> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text, // Example text
      style: TextStyle(
        color: widget.color, // Text color
        fontSize: widget.fontSize, // Text size
        fontWeight:widget.fontWeight, // Font style
         // Spacing between words
        decorationStyle: TextDecorationStyle.dashed, // Underline style
        height: 1.5, // Line height (leading)
      ),
      textAlign: TextAlign.center, // Align the text (centered)
      maxLines: 2, // Maximum number of lines
      overflow: TextOverflow.ellipsis, // Text overflow style
      textDirection: TextDirection.ltr, // Text direction
      softWrap: true, // Wrap text when overflow
      textScaleFactor: 1.2, // Scale the text size
    );
  }
}

import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpSuport extends StatefulWidget {
  const HelpSuport({super.key});

  @override
  State<HelpSuport> createState() => _HelpSuportState();
}

class _HelpSuportState extends State<HelpSuport> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: appColorPrimary,
    body: Column(
      children: const [
        Padding(
          padding: EdgeInsets.only(left: 10,top: 20),
          child: MyAppbar(text: "Help & Suport"),
        )
      ],
    ),
    );
  }
}
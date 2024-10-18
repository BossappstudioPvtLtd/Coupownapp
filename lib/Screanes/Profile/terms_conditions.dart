import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: appColorPrimary,
    body: Column(
      children: const [
        Padding(
          padding: EdgeInsets.only(left: 10,top: 20),
          child: MyAppbar(text: "Terms & Conditions"),
        )
      ],
    ),
    );
  }
}
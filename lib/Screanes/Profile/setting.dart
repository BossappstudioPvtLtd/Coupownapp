import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: appColorPrimary,
    body: Column(
      children:  [
        Padding(
          padding: EdgeInsets.only(left: 10,top: 20),
          child: MyAppbar(text: "Settings"),
        )
      ],
    ),
    );
  }
}
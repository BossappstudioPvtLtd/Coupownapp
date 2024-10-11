import 'package:flutter/cupertino.dart';

class Loading extends StatefulWidget {
final String text;
  const Loading({super.key, required this.text});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(content: Row( children: [ const CupertinoActivityIndicator(),const SizedBox(width: 20),Text(widget.text)],),);
  }
}
import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';

class Listilecard extends StatefulWidget {
  final String text;
  final void Function()? onTap;
  const Listilecard({super.key, required this.text, this.onTap});

  @override
  State<Listilecard> createState() => _ListilecardState();
}

class _ListilecardState extends State<Listilecard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(contentPadding: EdgeInsets.zero,
      title:  Padding(padding: const EdgeInsets.only(left: 10), child: Text(widget.text, style: const TextStyle(fontWeight: FontWeight.bold)),),
       trailing: const Row( mainAxisSize: MainAxisSize.min,
        children: [ Text('View All',style: TextStyle(fontSize: 14,color:appTextColorPrimary),),
          SizedBox(width: 8.0),
          Icon(Icons.arrow_forward_ios,size: 16,),
        ],
      ),
      onTap: widget.onTap,
    );
  }
}

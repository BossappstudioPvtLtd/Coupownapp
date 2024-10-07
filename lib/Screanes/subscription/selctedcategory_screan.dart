import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';

class SelectedItemsScreen extends StatelessWidget {
  final Map<String, List<String>> selectedItems;

  const SelectedItemsScreen({Key? key, required this.selectedItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorPrimary,
      appBar: AppBar(
        title: Text('Selected Subcategories'),
        backgroundColor:appColorPrimary
      ),
      body: ListView.builder(
        itemCount: selectedItems.keys.length,
        itemBuilder: (context, index) {
          String category = selectedItems.keys.elementAt(index);
          List<String> items = selectedItems[category]!;
          
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: appColorPrimary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...items.map((item) => Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                    child: Text(item),
                  )).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/subscription/selctedcategory_screan.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
 final List<String> _categories = [
    'Restaurant',
    'Hotel',
    'Shop',
    'Office',
    'Fashions',
    'Food & Dining',
    'Home & Living',
    'Furnitures',
    'Electrical Appliances',
    'Mobiles & Electronics',
    'Books & Stationery',
    'Grocery',
    'Beauty & Health',
    'Entertainment',
    'Sports Products',
    'Gifts & Jewels',
    'Automobiles',
    'Local Home Services',
    'Transportation Services',
    'Travel & Hospitality',
    'Others',
  ];

  final Map<String, List<String>> _subCategories = {
    'Restaurant': ['Clothing', 'Footwear',  'All'],
    'Hotel': ['Clothing', 'Footwear', 'Watch & Sunglass', 'Travel & Accessories', 'All'],
    'Fashions': [ 'Watch & Sunglass', 'Travel & Accessories', ],
    'Food & Dining': ['Restaurants', 'Drinks and Beverages', 'Street Food', 'Fast Food', 'All'],
    'Home & Living': ['Furniture & Decor', 'Kitchen & Dining', 'Bed & Bath', 'All'],
    'Electrical Appliances': ['Cooling Appliances', 'Refrigerator', 'Television', 'Washing Machine', 'Kitchen Accessories', 'All'],
  };

  Map<String, List<bool>> _selectedSubCategories = {};
  String _searchQuery = '';
  List<String> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    for (var category in _subCategories.keys) {
      _selectedSubCategories[category] = List<bool>.filled(_subCategories[category]!.length, false);
    }
    _filteredCategories = _categories; 
  }

  void _onCheckboxChanged(String category, int index, bool? value) {
    setState(() {
      _selectedSubCategories[category]![index] = value ?? false;
    });
  }

  void _applySelection() {
    Map<String, List<String>> selected = {};
    _selectedSubCategories.forEach((category, selectedList) {
      List<String> selectedItems = [];
      for (int i = 0; i < selectedList.length; i++) {
        if (selectedList[i]) {
          selectedItems.add(_subCategories[category]![i]);
        }
      }
      if (selectedItems.isNotEmpty) {
        selected[category] = selectedItems;
      }
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectedItemsScreen(selectedItems: selected),
      ),
    );
  }

  void _searchCategories(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _filteredCategories = _categories
          .where((category) => category.toLowerCase().contains(_searchQuery))
          .toList();
    });
  }

 @override
Widget build(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    color: const Color.fromARGB(255, 242, 243, 255),
    width: screenWidth * 0.9, // 90% of screen width
    height: screenHeight * 0.75, // 75% of screen height
    child: Column(
      children: [
        SizedBox(height: screenHeight * 0.03), // 3% of screen height
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close), 
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04), // 4% of screen width
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search Help About...',
              prefixIcon: const Icon(Icons.search), 
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true, 
              fillColor: Colors.white, 
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
            onChanged: _searchCategories,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredCategories.length,
            itemBuilder: (context, index) {
              String category = _filteredCategories[index];
              List<String>? subCategories = _subCategories[category];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      category,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (subCategories != null && subCategories.isNotEmpty)
                    ...subCategories.asMap().entries.map((entry) {
                      int subIndex = entry.key;
                      String subCategory = entry.value;
                      return Container(
                        color: appColorPrimary,
                        child: CheckboxListTile(
                          title: Text(
                            subCategory,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          value: _selectedSubCategories[category]![subIndex],
                          onChanged: (value) => _onCheckboxChanged(category, subIndex, value),
                        ),
                      );
                    }),
                ],
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.1, // 10% of screen width
              right: screenWidth * 0.1, // 10% of screen width
              bottom: screenHeight * 0.03, // 3% of screen height
            ),
            child: SmallButton(
              meterialColor: const Color.fromARGB(255, 15, 130, 19),
              containerheight: 40,
              containerwidth: 400,
              onTap: _applySelection,
              elevationsize: 20,
              text: 'Apply',
            ),
          ),
        ),
      ],
    ),
  );
}
}
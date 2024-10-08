import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/All%20featured/category_detils.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:flutter/material.dart';
class MoreCategories extends StatefulWidget {
  const MoreCategories({super.key});

  @override
  State<MoreCategories> createState() => _MoreCategoriesState();  
}

class _MoreCategoriesState extends State<MoreCategories> {
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

  List<String> _filteredCategories = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCategories = _categories; // Initially, display all categories
    _searchController.addListener(_filterCategories);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCategories = _categories
          .where((category) => category.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorPrimary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: MyAppbar(text: "More Categories"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(32),
                color: appColorPrimary,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.mic),
                      onPressed: () {
                        print('Voice input tapped');
                      },
                    ),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredCategories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: appColorPrimary,
                      child: InkWell(
                        onTap: () {
                          // Navigate to CategoryDetailPage on tap
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryDetils(categoryName: _filteredCategories[index]),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: ListTile(
                          title: Text(_filteredCategories[index],style: const TextStyle(fontWeight:FontWeight.bold ),),
                          trailing: const Icon(Icons.arrow_forward_ios_outlined),
                          subtitle: const Text("120 Offers"),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}






import 'package:coupown/Screanes/subscription/api_const.dart/category.dart';
import 'package:coupown/Screanes/subscription/api_const.dart/post.dart';
import 'package:flutter/material.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({super.key});

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  late Future<List<Category>> _categoriesFuture;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Category Dropdown'),),
      body: Center(
        child: FutureBuilder<List<Category>>(
          future: _categoriesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No categories available');
            }

            final categories = snapshot.data!;

            return DropdownButton<String>(
              hint: Text('Select a category'),
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
              items: categories.map((Category category) {
                return DropdownMenuItem<String>(
                  value: category.categoriesName,
                  child: Text(category.categoriesName),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

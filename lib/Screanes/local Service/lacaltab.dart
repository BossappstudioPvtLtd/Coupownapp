import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';

import 'home_service.dart';
import 'installation.dart';
import 'local_service_all.dart';

class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  _TabBarExampleState createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColorPrimary,
        leading: Row(
          children: [
            Material(
              color: appColorPrimary ,
              elevation: 5,
              borderRadius: BorderRadius.circular(32),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to previous screen
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
              ),
            ),
            const SizedBox(width: 8), // Spacing between icon and text
           
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(left: 120),
            child: Flexible(  // Constrain the text within the available space
                child: Text(
                  "Local Service",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Change text color as needed
                  ),
                  overflow: TextOverflow.ellipsis, // Ensure long text doesn't overflow
                ),
              ),
          ), Spacer(),],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Installation'),
            Tab(text: 'Home Services'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          LocalService(), // Ensure LocalService widget is defined
          Installation(),
          HomeService(),
        ],
      ),
    );
  }
}

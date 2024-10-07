import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';

class FeaturesTab extends StatefulWidget {
  final Map<String, dynamic> deal;
  const FeaturesTab({super.key, required this.deal});

  @override
  State<FeaturesTab> createState() => _FeaturesTabState();
}

class _FeaturesTabState extends State<FeaturesTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorPrimary,
      appBar: AppBar(
        backgroundColor: appColorPrimary,
        title: Text(widget.deal['name']),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Flight'),
            Tab(text: 'Hotel'),
            Tab(text: 'Bus'),
            Tab(text: 'Train'),
            Tab(text: 'Cab'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(child: Text('All')),
          Center(child: Text('Flight')),
          Center(child: Text('Hotel')),
          Center(child: Text('Bus')),
          Center(child: Text('Train')),
          Center(child: Text('Cab')),
        ],
      ),
    );
  }
}

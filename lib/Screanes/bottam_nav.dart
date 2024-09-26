import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/coupown_screen.dart';
import 'package:coupown/Screanes/dash_board_screen.dart';
import 'package:coupown/Screanes/favorite_screen.dart';
import 'package:coupown/Screanes/profile_screen.dart';
import 'package:flutter/material.dart';


class BottamNav extends StatefulWidget {
  const BottamNav({super.key});

  @override
  _BottamNavState createState() => _BottamNavState();
}

class _BottamNavState extends State<BottamNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    const PaymentMethodPage(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: appColorPrimary,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined),
            label: 'Coupown',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handshake_outlined),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:appColorAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}









import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/widgets/appbar_containers.dart';
import 'package:coupown/widgets/image_slider_widgets.dart';
import 'package:coupown/widgets/search_widgets.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: double.infinity,
        color:appColorPrimary ,
        child:   Column(
          children: [
            const SizedBox(height: 50,),
            const AppbarContainers(),
            
            const SizedBox(height: 30,),
           
            
                const SearchWidgets(),
            const SizedBox(height: 30,),
               
             ImageSlider(),
          ],
        ),
      ),
    );
  }
}
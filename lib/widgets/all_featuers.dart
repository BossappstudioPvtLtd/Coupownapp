import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/widgets/my_row_widgets.dart';

class AvatarListView extends StatefulWidget {
  const AvatarListView({super.key});

  @override
  _AvatarListViewState createState() => _AvatarListViewState();
}

class _AvatarListViewState extends State<AvatarListView>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> users = [
    {'name': 'Travels', 'imageUrl': 'assets/featurerd/travel.png'},
    {'name': 'Groceries', 'imageUrl': 'assets/featurerd/collectionfood.png'},
    {'name': 'Food & Dining', 'imageUrl': 'assets/featurerd/dinnerset.png'},
    {'name': 'Fashion', 'imageUrl': 'assets/featurerd/store.png'},
    {'name': 'Entertainment', 'imageUrl': 'assets/featurerd/clapperboard.png'},
    {'name': 'Appliances', 'imageUrl': 'assets/featurerd/ele.png'},
    {'name': 'Home & Living', 'imageUrl': 'assets/featurerd/furnitures.png'},
    {'name': 'Mobiles & Tabs', 'imageUrl': 'assets/featurerd/smartphone.png'},
    {'name': 'Books & Stationery', 'imageUrl': 'assets/featurerd/stationery.png'},
    {'name': 'Sport Hub', 'imageUrl': 'assets/featurerd/topview.png'},
    {'name': 'Gifts & Jewels', 'imageUrl': 'assets/featurerd/valentines.png'},
    {'name': 'Automobiles', 'imageUrl': 'assets/featurerd/caroil.png'},
    {'name': 'Local Service', 'imageUrl': 'assets/featurerd/measuring.png'},
  ];

  bool showMyRowWidget = true;
  Alignment alignment = Alignment.centerLeft; // Start from the left

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400; // Define your breakpoint for small screens
    final isMediumScreen = screenWidth >= 400 && screenWidth <= 600; // Define breakpoint for medium screens
    final isWideScreen = screenWidth > 600; // Define breakpoint for wide screens

    return Container(
      height: isWideScreen ? 220 : (isMediumScreen ? 200 : 170), // Adjust height based on screen size
      color: const Color.fromARGB(210, 237, 247, 251),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: showMyRowWidget,
                child: const MyRowWidget(),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(
                  left: isWideScreen ? 300 : (isMediumScreen ? 270 : 250), // Adjust padding for different screen sizes
                  right: 30,
                ),
                child: AnimatedAlign(
                  alignment: alignment, // Animate alignment from left to right
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: Visibility(
                    visible: !showMyRowWidget,
                    child: const Material(
                      color: appColorPrimary,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 6, bottom: 6),
                        child: Row(
                          children: [
                            Textedit(text: "more >>", fontSize: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification) {
                      final metrics = scrollNotification.metrics;
                      if (metrics.atEdge) {
                        if (metrics.pixels == 0) {
                          // Scroll is at the start
                          setState(() {
                            showMyRowWidget = true;
                            alignment = Alignment.centerLeft; // Reset animation
                          });
                        } else {
                          // Scroll is at the end
                          setState(() {
                            showMyRowWidget = false;
                            alignment = Alignment.centerRight; // Trigger animation
                          });
                        }
                      } else {
                        // Scroll is neither at start nor end
                        setState(() {
                          showMyRowWidget = true;
                          alignment = Alignment.centerLeft; // Reset animation
                        });
                      }
                    }
                    return true;
                  },
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return GestureDetector(
                        onLongPress: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(user['name']),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 5 : 10, // Adjust padding for small screens
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: isWideScreen ? 40 : (isMediumScreen ? 37 : 34), // Adjust radius based on screen size
                                    backgroundColor: appColorAccent,
                                    child: CircleAvatar(
                                      backgroundColor: appLight_purple,
                                      radius: isWideScreen ? 39 : (isMediumScreen ? 36 : 33), // Adjust radius based on screen size
                                      child: CircleAvatar(
                                        radius: isWideScreen ? 36 : (isMediumScreen ? 33 : 30), // Adjust radius based on screen size
                                        backgroundColor: appColorPrimary,
                                        backgroundImage: AssetImage(user['imageUrl']),
                                        child: ClipOval(
                                          child: Image.asset(
                                            user['imageUrl'],
                                            fit: BoxFit.fill,
                                            width: isWideScreen ? 70 : (isMediumScreen ? 65 : 60), // Adjust width for different screen sizes
                                            height: isWideScreen ? 70 : (isMediumScreen ? 65 : 60), // Adjust height for different screen sizes
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                user['name'],
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 14 : 16, // Adjust font size for small screens
                                  fontWeight: FontWeight.bold,
                                  color: iconColorSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
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

  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  bool showMyRowWidget = true;
  Alignment alignment = Alignment.centerLeft;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _slideInAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final isMediumScreen = screenWidth >= 400 && screenWidth <= 600;
    final isWideScreen = screenWidth > 600;

    return Container(
      height: isWideScreen ? 220 : (isMediumScreen ? 200 : 170),
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
                  left: isWideScreen ? 300 : (isMediumScreen ? 270 : 250),
                  right: 30,
                ),
                child: AnimatedAlign(
                  alignment: alignment,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: Visibility(
                    visible: !showMyRowWidget,
                   
                      child:  Padding(
                        padding: EdgeInsets.only(left: 10, top: 6, bottom: 6),
                        child: Row(
                          children: [
                            //Textedit(text: "more >>", fontSize: 12,fontWeight:FontWeight.bold ,),
                             AnimatedTextKit(totalRepeatCount: 100,
                                      pause: Duration.zero,
                                    animatedTexts: [  ColorizeAnimatedText("more >>",
                                    textStyle: const TextStyle( fontSize: 16.0,fontWeight: FontWeight.bold, ),
                                     colors: [ Colors.grey, Colors.grey, Colors.white, Colors.black, Colors.black,],),], isRepeatingAnimation: true,),
                          ],
                          
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
                          setState(() {
                            showMyRowWidget = true;
                            alignment = Alignment.centerLeft;
                          });
                        } else {
                          setState(() {
                            showMyRowWidget = false;
                            alignment = Alignment.centerRight;
                          });
                        }
                      }
                    }
                    return true;
                  },
                  child: SlideTransition(
                    position: _slideInAnimation,
                    child: FadeTransition(
                      opacity: _fadeInAnimation,
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
                                horizontal: isSmallScreen ? 5 : 10,
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: isWideScreen
                                            ? 40
                                            : (isMediumScreen ? 37 : 34),
                                        backgroundColor: appColorAccent,
                                        child: CircleAvatar(
                                          backgroundColor: appLight_purple,
                                          radius: isWideScreen
                                              ? 39
                                              : (isMediumScreen ? 36 : 33),
                                          child: CircleAvatar(
                                            radius: isWideScreen
                                                ? 36
                                                : (isMediumScreen ? 33 : 30),
                                            backgroundColor: appColorPrimary,
                                            backgroundImage: AssetImage(user['imageUrl']),
                                            child: ClipOval(
                                              child: Image.asset(
                                                user['imageUrl'],
                                                fit: BoxFit.fill,
                                                width: isWideScreen
                                                    ? 70
                                                    : (isMediumScreen ? 65 : 60),
                                                height: isWideScreen
                                                    ? 70
                                                    : (isMediumScreen ? 65 : 60),
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
                                      fontSize: isSmallScreen ? 14 : 16,
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

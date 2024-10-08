
import 'package:coupown/Screanes/All%20featured/features_tab.dart';
import 'package:coupown/Screanes/All%20featured/more_categories.dart';
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
  final List<Map<String, dynamic>> features = [
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
                  left: isWideScreen ? 290 : (isMediumScreen ? 270 : 250),
                
                ),
                child: AnimatedAlign(
                  alignment: alignment,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: Visibility(
                    visible: !showMyRowWidget,
                   
                      child: Padding(
  padding: const EdgeInsets.only(left: 30, top: 6, bottom: 6 ),
  child: Row(
    children: [
     TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MoreCategories(),
      ),
    );
  },
  child: const Text(
    "more >>",
    style: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Colors.black, // Change to the desired color
    ),
  ),
),

    ],
  ),
)

                    
                  ),
                ),
              ),
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
                        itemCount: features.length,
                        itemBuilder: (context, index) {
                        final deal = features[index];
                          return GestureDetector(
                            onLongPress: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(deal['name']),
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
                                      InkWell(
                                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  FeaturesTab( deal: {
                    'name': '${deal['name']}',
                    'All': const [
                      {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image6.png',
      'name': 'Travels',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "50%",
      "offerpercentage": "20%",
      "coupownoffer": "10",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      "Joboffer": "sales executive",
      'count': 0,
      "valid date": "15/09/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 24),
    },
    {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },
    {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image8.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "sales executive",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },
    {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image9.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },
                    ],
                    'Flight': const [
                      {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image14.jpg',
      'name': 'Travels',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "50%",
      "offerpercentage": "20%",
      "coupownoffer": "10",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      "Joboffer": "sales executive",
      'count': 0,
      "valid date": "15/09/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 24),
    },
    {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image15.jpg',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },
    {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image16.jpg',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "sales executive",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },
    {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/Image17.jpg',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },
                    ],
                    'Hotel': const [
                    {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image10.png',
      'name': 'Travels',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "50%",
      "offerpercentage": "20%",
      "coupownoffer": "10",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      "Joboffer": "sales executive",
      'count': 0,
      "valid date": "15/09/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 24),
    },
    {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image11.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },
    {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image12.webp',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "sales executive",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },
    {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image13.jpg',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },
                    ],
                    'Bus': const [ {
      'logoUrl': 'assets/featurerd/travel.png',
      'productUrl': 'assets/Special0ffer/image1.png',
      'name': 'Travels',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "50%",
      "offerpercentage": "20%",
      "coupownoffer": "10",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      "Joboffer": "sales executive",
      'count': 0,
      "valid date": "15/09/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 24),
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/Special0ffer/Image2.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/Special0ffer/image3.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "sales executive",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/Special0ffer/image4.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },],
                    'Train': const [ {
      'logoUrl': 'assets/featurerd/travel.png',
      'productUrl': 'assets/Special0ffer/image1.png',
      'name': 'Travels',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "50%",
      "offerpercentage": "20%",
      "coupownoffer": "10",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      "Joboffer": "sales executive",
      'count': 0,
      "valid date": "15/09/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 24),
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/Special0ffer/Image2.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/Special0ffer/image3.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "sales executive",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/Special0ffer/image4.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },],
                    'Cab': const [ {
      'logoUrl': 'assets/featurerd/travel.png',
      'productUrl': 'assets/Special0ffer/image1.png',
      'name': 'Travels',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "50%",
      "offerpercentage": "20%",
      "coupownoffer": "10",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      "Joboffer": "sales executive",
      'count': 0,
      "valid date": "15/09/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 24),
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/Special0ffer/Image2.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/Special0ffer/image3.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "sales executive",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/Special0ffer/image4.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 12),
    },],
                  },),
                            ),
                          );
                        },
                                        child: CircleAvatar(
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
                                              backgroundImage: AssetImage(deal['imageUrl']),
                                              child: ClipOval(
                                                child: Image.asset(
                                                  deal['imageUrl'],
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
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    deal['name'],
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

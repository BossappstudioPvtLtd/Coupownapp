import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';



class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final List<Map<String, dynamic>> todatdeal = [
    {
      'logoUrl': 'assets/featurerd/travel.png',
      'productUrl': 'assets/featurerd/image 15.png',
      'name': 'Travels',
      'price': "2499",
      'offerprice': "1500",
      'percentage': "60%",
      'discretion': "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'isFavorite': false,
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/featurerd/image 15 (1).png',
      'name': 'Food',
      'price': "2499",
      'offerprice': "1500",
      'percentage': "50%",
      'discretion': "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'isFavorite': false,
    },
    {
      'logoUrl': 'assets/featurerd/dinnerset.png',
      'productUrl': 'assets/featurerd/image 15 (2).png',
      'name': 'Dinner Set',
      'price': "2499",
      'offerprice': "1500",
      'percentage': "60%",
      'discretion': "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'isFavorite': false,
    },
    {
      'logoUrl': 'assets/featurerd/store.png',
      'productUrl': 'assets/featurerd/travel.png',
      'name': 'Store',
      'price': "2499",
      'offerprice': "1500",
      'percentage': "70%",
      'discretion': "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'isFavorite': false,
    },
  ];
  void deleteDeal(int index) {
    setState(() {
      todatdeal.removeAt(index);
    });
  }


    @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    bool isMediumScreen = MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1200;

    return Scaffold(
      backgroundColor: appColorPrimary,
      appBar: AppBar(
        title: const Text('Deals'),
        
      backgroundColor: appColorPrimary,
      ),
      body: ListView.builder(
        itemCount: todatdeal.length,
        itemBuilder: (context, index) {
          final deal = todatdeal[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              color: appColorPrimary,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 8 : 10,
                    vertical: isSmallScreen ? 8 : 10),
                leading: CircleAvatar(
                  
                    radius: isSmallScreen ? 35 : (isMediumScreen ? 37 : 40),
                    backgroundColor:appColorAccent, // Replace with your accent color
                  child: CircleAvatar(
                    radius: isSmallScreen ? 30 : (isMediumScreen ? 37 : 40),
                    backgroundColor:appColorAccent, // Replace with your accent color
                    child: CircleAvatar(
                      radius: isSmallScreen ? 29 : (isMediumScreen ? 36 : 39),
                      backgroundColor:appColorAccent, // Replace with your primary color
                      backgroundImage: AssetImage(deal['logoUrl']),
                    ),
                  ),
                ),
                title: Text(
                  deal['name'],
                  style: TextStyle(
                    fontSize: isSmallScreen ? 18 : 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  '18 Locations',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 8 : 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red, // Replace with your dark red color
                  ),
                  onPressed: () {
                    deleteDeal(index);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  }


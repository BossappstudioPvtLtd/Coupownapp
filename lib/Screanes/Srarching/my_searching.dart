
import 'package:coupown/Screanes/Srarching/searching_area.dart';
import 'package:flutter/material.dart';
import 'package:coupown/Const/app_colors.dart';

class Shop {
  final String name;
  final String address;
  final List<String> foodList;
  final List<String> dressList;
  final List<String> shopList;

  Shop({
    required this.name,
    required this.address,
    required this.foodList,
    required this.dressList,
    required this.shopList,
  });
}

class ShopItem {
  final String item;
  final Shop shop;

  ShopItem({required this.item, required this.shop});
}

class MySearching extends StatefulWidget {
  const MySearching({super.key});

  @override
  State<MySearching> createState() => _MySearchingState();
}

class _MySearchingState extends State<MySearching> {
 

  List<Shop> initialShops = [
    Shop(
      name: 'Apple Store',
      address: '123 Orchard Road',
      foodList: ['Apple', 'Apple Juice', 'Apple Jam'],
      dressList: ['T-Shirt', 'Hoodie'],
      shopList: ['Electronics', 'Accessories'],
    ),
    Shop(
      name: 'Banana Shop',
      address: '456 Banana Street',
      foodList: ['Banana Smoothie', 'Banana Cake'],
      dressList: ['Dress', 'Socks'],
      shopList: ['Fruits', 'Vegetables'],
    ),
    Shop(
      name: 'Orange Mart',
      address: '789 Citrus Avenue',
      foodList: ['Orange Juice', 'Orange Marmalade'],
      dressList: ['Orange Shirt', 'Orange Cap'],
      shopList: ['Citrus Fruits', 'Snacks'],
    ),
    Shop(
      name: 'Mango Market',
      address: '101 Mango Lane',
      foodList: ['Mango Lassi', 'Mango Ice Cream'],
      dressList: ['Mango Dress', 'Mango Scarf'],
      shopList: ['Fruits', 'Sweets'],
    ),
    Shop(
      name: 'Pineapple Place',
      address: '202 Pineapple Road',
      foodList: ['Pineapple Juice', 'Pineapple Cake'],
      dressList: ['Shorts', 'Hat'],
      shopList: ['Fruits', 'Souvenirs'],
    ),
     Shop(
      name: 'Apple Store',
      address: '123 Orchard Road',
      foodList: ['Apple', 'Apple Juice', 'Apple Jam'],
      dressList: ['T-Shirt', 'Hoodie'],
      shopList: ['Electronics', 'Accessories'],
    ),
    Shop(
      name: '4 Shop',
      address: '456 Banana Street',
      foodList: ['Banana Smoothie', 'Banana Cake'],
      dressList: ['Dress', 'Socks'],
      shopList: ['Fruits', 'Vegetables'],
    ),
    Shop(
      name: '3 Mart',
      address: '789 Citrus Avenue',
      foodList: ['Orange Juice', 'Orange Marmalade'],
      dressList: ['Orange Shirt', 'Orange Cap'],
      shopList: ['Citrus Fruits', 'Snacks'],
    ),
    Shop(
      name: '2 Market',
      address: '101 Mango Lane',
      foodList: ['Mango Lassi', 'Mango Ice Cream'],
      dressList: ['Mango Dress', 'Mango Scarf'],
      shopList: ['Fruits', 'Sweets'],
    ),
    Shop(
      name: '1 Place',
      address: '202 Pineapple Road',
      foodList: ['Pineapple Juice', 'Pineapple Cake'],
      dressList: ['Shorts', 'Hat'],
      shopList: ['Fruits', 'Souvenirs'],
    ),
  ];

  List<ShopItem> filteredList = [];

  @override
  void initState() {
    super.initState();
    // Initially, show all items
    filteredList = initialShops.expand((shop) {
      return shop.foodList.map((item) {
        return ShopItem(item: item, shop: shop);
      }).toList();
    }).toList();
  }

  void _filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<ShopItem> tempList = [];
      initialShops.forEach((shop) {
        shop.foodList.forEach((item) {
          if (item.toLowerCase().contains(query.toLowerCase())) {
            tempList.add(ShopItem(item: item, shop: shop));
          }
        });
      });
      setState(() {
        filteredList = tempList;
      });
    } else {
      setState(() {
        filteredList = initialShops.expand((shop) {
          return shop.foodList.map((item) {
            return ShopItem(item: item, shop: shop);
          }).toList();
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SearchAnchor.bar(
              viewBackgroundColor: appColorPrimary,
              viewLeading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              barTrailing: const [
                Icon(
                  Icons.mic,
                  color: iconColorSecondary,
                ),
              ],
              barBackgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              barHintText: "Searching...",
              barHintStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: appTextColorSecondary),
              ),
              suggestionsBuilder: (BuildContext context, TextEditingController controller) {
                _filterSearchResults(controller.text);
                return List<Widget>.generate(filteredList.length, (int index) {
                  return Card(
                    color: appColorPrimary,
                    elevation: 5,
                    shadowColor: appColorPrimary,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      title: Text(filteredList[index].item),
                       onTap: () {
                        // Navigate to the shop details page when an item is clicked
                        Navigator.push(
                           context,
                          MaterialPageRoute(
                            builder: (context) => SearchingArea(
                               shop: filteredList[index].shop,
                          ),
                          ),
                         );
                       },
                    ),
                  );
                });
              },
            ),
          ),
        ],
      
    );
  }
}

class ShopDetailsPage extends StatelessWidget {
  final Shop shop;

  const ShopDetailsPage({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shop Name: ${shop.name}',  // Displaying the shop name on the page
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            
              Text(
                'Address: ${shop.address}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              
             
            ],
          ),
        ),
      ),
    );
  }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:coupown/components/text_edit.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  List<Map<String, dynamic>> reviews = [
   
    {
      'userUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image.png',
      'headereviews': 'Adventure Explore the World',
      "subreviews": "First, decide where you will store the reviews. Firebase Firestore or Realtime Database is a good choice for storing user reviews.First, decide where you will store the reviews. Firebase Firestore or Realtime Database is a good choice for storing user reviews.First, decide where you will store the reviews. Firebase Firestore or Realtime Database is a good choice for storing user reviews.First, decide where you will store the reviews. Firebase Firestore or Realtime Database is a good choice for storing user reviewsFirst, decide where you will store the reviews. Firebase Firestore or Realtime Database is a good choice for storing user reviews.First, decide where you will store the reviews. Firebase Firestore or Realtime Database is a good choice for storing user reviews.First, decide where you will store the reviews. Firebase Firestore or Realtime Database is a good choice for storing user reviews.First, decide where you will store the reviews. Firebase Firestore or Realtime Database is a good choice for storing user reviews.",
      'rating': "4.0",
      "valid date": "15/08/2024",
    },
     {
      'userUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image.png',
      'headereviews': 'Adventure Explore the World',
      "subreviews": "First, decide where you will store the reviews. Firebase Firestore or Realtime Database is a good choice for storing user reviews.",
      'rating': "5.0",
      "valid date": "15/08/2024",
    },
     {
      'userUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image.png',
      'headereviews': 'Adventure Explore the World',
      "subreviews": "First, decide where you will store the reviews. Firebase Firestore or Realtime Database is a good choice for storing user reviews.",
      'rating': "5.0",
      "valid date": "15/08/2024",
    },
     {
      'userUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image.png',
      'headereviews': 'Adventure Explore the World',
      "subreviews": "First, decide where you will store the reviews. Firebase Firestore or Realtime Database is a good choice for storing user reviews.",
      'rating': "5.0",
      "valid date": "15/08/2024",
    },
    // Add more reviews here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorPrimary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 20),
              child: MyAppbar(text: "Reviews"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(16),
                      elevation: 5,
                      color: appColorPrimary,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Avatar
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(review['userUrl']),
                              ),
                              const SizedBox(width: 10),
                              // Review details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header with date and more icon
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${review["valid date"]}"),
                                        const Icon(Icons.more_horiz_sharp),
                                      ],
                                    ),
                                    // Product name
                                    Textedit(
                                      text: '${review['headereviews']}',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    // Star rating and numeric rating
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                          rating: double.parse(review['rating'] ?? '0.0'),
                                          itemBuilder: (context, index) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 20.0,
                                          direction: Axis.horizontal,
                                        ),
                                        const SizedBox(width: 8),
                                        Text("${review['rating']}"),  // Numeric rating
                                      ],
                                    ),
                                    // Review description
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: SingleChildScrollView(
                                          child: InkWell(onTap: (){
                                            showReviewDialog(context, review['subreviews']);


                                          },child: Text("${review['subreviews']}")),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//cupertinoDialoge

void showReviewDialog(BuildContext context, String reviewContent) {
  showCupertinoDialog(  context: context,builder: (BuildContext context) {
      return CupertinoAlertDialog( title: const Text('Review', style: TextStyle(color: Colors.black),),
        content: Text( reviewContent,style: const TextStyle(color: Colors.black), ),
        actions: <Widget>[ CupertinoDialogAction(onPressed: () { Navigator.of(context).pop();}, child: const Text('OK'),),
        ],
      );
    },
  );
}


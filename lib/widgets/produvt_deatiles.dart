import 'dart:async';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';

class DealDetailPage extends StatefulWidget {
  final Map<String, dynamic> deal;

  const DealDetailPage({super.key, required this.deal});

  @override
  _DealDetailPageState createState() => _DealDetailPageState();
}

class _DealDetailPageState extends State<DealDetailPage> {
  late Timer _timer;
  late Map<String, dynamic> deal; // Local mutable copy of widget.deal
  Duration remainingTime = const Duration(hours: 24); // 24-hour countdown

  @override
  void initState() {
    super.initState();
    deal = Map.from(widget.deal); // Create a mutable copy of widget.deal
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        setState(() {
          remainingTime = remainingTime - const Duration(seconds: 1);
        });
      } else {
        _timer.cancel(); // Stop the timer when countdown reaches zero
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          deal['productUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 240,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                deal['productname'],
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "Offer Valid to ",
                                          style: TextStyle(fontSize: 14, color: appTextColorPrimary),
                                        ),
                                        TextSpan(
                                          text: "${deal['valid date']}",
                                          style: TextStyle(fontSize: 16, color: appDarkRed, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "starts at ",
                                          style: TextStyle(fontSize: 14, color: appTextColorPrimary),
                                        ),
                                        TextSpan(
                                          text: "₹${deal['offerprice']}",
                                          style: const TextStyle(fontSize: 20, color: appTextColorPrimary, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "₹${deal['price']}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: appTextColorPrimary,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "Location ",
                                          style: TextStyle(fontSize: 14, color: appTextColorPrimary),
                                        ),
                                        TextSpan(
                                          text: "${deal['location']}",
                                          style: TextStyle(fontSize: 16, color: textColorPrimary, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Material(
                                    color: appDarkRed,
                                    borderRadius: BorderRadius.circular(32),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10, left: 10),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.alarm),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(formatDuration(remainingTime)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Row(
                                    children: [
                                      Text(
                                        "${deal['rating']}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const Icon(Icons.star, color: Colors.amber),
                                      Text(
                                        "130 ",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Textedit(text: "Ratings", fontSize: 10),
                                    ],
                                  ),
                                ],
                              ),
                            
                            ],
                          ),
                        ),
                         Positioned(
                          top: 400,
                           child: Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    deal['isPressed'] ? Icons.handshake : Icons.handshake,
                                  ),
                                  color: deal['isPressed'] ? Colors.pink : Colors.grey,
                                  iconSize: 30.0,
                                  onPressed: () {
                                    setState(() {
                                      deal['isPressed'] = !deal['isPressed'];
                                      deal['count'] += deal['isPressed'] ? 1 : -1;
                                    });
                                  },
                                ),
                                Textedit( fontSize: 20, text:'${deal['count']}',),
                              ],
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
      ),
    );
  }
}

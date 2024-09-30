import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:flutter/material.dart';

class JobScreen extends StatefulWidget {
  final Map<String, dynamic> deal;
  const JobScreen({super.key, required this.deal});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final isMediumScreen = screenWidth >= 400 && screenWidth <= 600;

    return Scaffold(
      backgroundColor: appColorPrimary,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: MyAppbar(text: "Jobs Offers"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    child: Container(
                      height: isSmallScreen ? 80 : 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 8 : 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: isSmallScreen
                                  ? 30
                                  : (isMediumScreen ? 37 : 40),
                              backgroundColor: appColorAccent,
                              child: CircleAvatar(
                                backgroundColor: appLight_purple,
                                radius: isSmallScreen
                                    ? 29
                                    : (isMediumScreen ? 36 : 39),
                                child: CircleAvatar(
                                  radius: isSmallScreen
                                      ? 26
                                      : (isMediumScreen ? 33 : 36),
                                  backgroundColor: appColorPrimary,
                                  backgroundImage:
                                      AssetImage(widget.deal['logoUrl']),
                                  child: ClipOval(
                                    child: Image.asset(
                                      widget.deal['logoUrl'],
                                      fit: BoxFit.cover,
                                      width: isSmallScreen
                                          ? 50
                                          : (isMediumScreen ? 60 : 70),
                                      height: isSmallScreen
                                          ? 50
                                          : (isMediumScreen ? 60 : 70),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: isSmallScreen ? 8 : 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.deal['name'],
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 18 : 24,
                                      fontWeight: FontWeight.bold,
                                      color: appTextColorSecondary,
                                    ),
                                  ),
                                  Text(
                                    '18 Locations',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 8 : 10,
                                      fontWeight: FontWeight.bold,
                                      color: appTextColorSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: isSmallScreen ? 8 : 15),
                            Icon(Icons.share, size: isSmallScreen ? 20 : 24),
                            IconButton(
                              icon: Icon(
                                widget.deal['isFavorite']
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: widget.deal['isFavorite']
                                    ? Colors.red
                                    : Colors.grey,
                                size: isSmallScreen ? 24 : 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  widget.deal['isFavorite'] =
                                      !widget.deal['isFavorite'];
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 350,
                      width: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: widget.deal['productUrl'] != null
                                      ? DecorationImage(
                                          image: AssetImage(widget.deal['productUrl']),
                                          fit: BoxFit.fill,
                                        )
                                      : null, // Provide a default in case of null
                                ),
                                child: widget.deal['productUrl'] == null
                                    ? Center(
                                        child: Column(
                                          children: [
                                            _buildJobOfferHeader(),
                                            const SizedBox(height: 5),
                                            _buildLocationRow(),
                                            const SizedBox(height: 5),
                                            _buildJobTypeButtons(),
                                            const SizedBox(height: 5),
                                            _buildContactRow(),
                                            
                                          ],
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 5),
                            _buildJobOfferHeader(),
                            const SizedBox(height: 5),
                            _buildLocationRow(),
                            const SizedBox(height: 5),
                            _buildJobTypeButtons(),
                            const SizedBox(height: 5),
                            _buildContactRow(),
                            
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildJobOfferHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.deal['Joboffer'],
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: appTextColorSecondary,
          ),
        ),
        Row(
          children: [
            const Icon(Icons.share, size: 24),
            IconButton(
              icon: Icon(
                widget.deal['isFavorite']
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: widget.deal['isFavorite'] ? Colors.red : Colors.grey,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  widget.deal['isFavorite'] = !widget.deal['isFavorite'];
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Row _buildLocationRow() {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined, size: 20),
        const SizedBox(width: 4),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: "Location ",
                style: TextStyle(fontSize: 14, color: appTextColorPrimary),
              ),
              TextSpan(
                text: "${widget.deal['location']}",
                style: const TextStyle(
                  fontSize: 16,
                  color: appTextColorPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildJobTypeButtons() {
    return Row(
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green[50]),
          ),
          onPressed: () {},
          child: const Text(
            "Full-time",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green[50]),
          ),
          onPressed: () {},
          child: const Text(
            "Part-time",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Row _buildContactRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmallButton(
          icon: Icons.phone_in_talk,
          iconcolor: appColorPrimary,
          elevationsize: 5,
          text: "+91 98847 xxxxx ",
          containerheight: 40,
          borderRadius: BorderRadius.circular(8),
          containerwidth: 160
        ),
        const Text("2 days ago", style: TextStyle(color: Colors.black)),
      ],
    );
  }
}

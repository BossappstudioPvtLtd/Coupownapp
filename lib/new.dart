import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:getwidget/getwidget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart'; // Import the whatsapp_unilink package
import 'package:coupown/Const/add_model.dart'; // Ensure the model is defined correctly

class AdvertisementScreen extends StatefulWidget {
  const AdvertisementScreen({super.key});

  @override
  _AdvertisementScreenState createState() => _AdvertisementScreenState();
}

class _AdvertisementScreenState extends State<AdvertisementScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('advertisements/header_ad');
  List<Advertisement> _ads = [];

  @override
  void initState() {
    super.initState();
    _fetchAdvertisements();
  }

  // Function to fetch advertisements data from Firebase
  Future<void> _fetchAdvertisements() async {
    try {
      DataSnapshot snapshot = await _dbRef.get();
      if (snapshot.exists) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          Advertisement ad = Advertisement.fromMap(value);
          _ads.add(ad);
        });
        setState(() {});
      } else {
        print('No data available.');
      }
    } catch (e) {
      print("Error fetching advertisements: $e");
    }
  }

  // Function to launch the web link in a WebView
  void _openWebView(String url, String phoneNumber) {
    if (url.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(url: url, phoneNumber: phoneNumber),
        ),
      );
    } else {
      print("No web link available for this ad.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No web link available."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Header Ads'),
      ),
      body: _ads.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _ads.length,
              itemBuilder: (context, index) {
                Advertisement ad = _ads[index];
                return Card(
                  child: ListTile(
                    title: Text(ad.companyName),
                    subtitle: Text('${ad.fromDate} to ${ad.toDate}'),
                    leading: ad.selectedImage.isNotEmpty
                        ? Image.network(ad.selectedImage)
                        : const Icon(Icons.image_not_supported),
                    trailing: Text(ad.phone),
                    onTap: () {
                      _openWebView(ad.webLink, ad.phone);
                    },
                  ),
                );
              },
            ),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String url;
  final String phoneNumber;

  const WebViewScreen({Key? key, required this.url, required this.phoneNumber}) : super(key: key);

  @override
  State<WebViewScreen> createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  // Function to send a WhatsApp message
  Future<void> _sendWhatsAppMessage(BuildContext context, String phoneNumber) async {
    final link = WhatsAppUnilink(
      phoneNumber: phoneNumber,
      text: "Hello! I saw your advertisement on your app.",
    );

    try {
      await launch('$link');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch WhatsApp: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (_isLoading)
            const Center(
              child: GFLoader(type: GFLoaderType.ios),
            ),
          // WhatsApp button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () => _sendWhatsAppMessage(context, widget.phoneNumber),
              child: const Icon(Icons.message),
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

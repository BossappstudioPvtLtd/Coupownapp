
import 'package:coupown/Const/appwidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

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
    
  print("Phone Number: +++++++++++++++++++++++++++++++++${widget.phoneNumber}");  

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
    
    
    changeStatusColor(Colors.transparent);
    return 
       Stack(
        children: [
          WebViewWidget(controller: controller),
          if (_isLoading)
            const Center(
              child: GFLoader(type: GFLoaderType.ios),
            ),
          // WhatsApp button
        Positioned(
  bottom: 10,
  left: 0,
  right: 0,
  child: Align(
    alignment: Alignment.bottomCenter,
    child: GestureDetector(
      onTap: () => _sendWhatsAppMessage(context, widget.phoneNumber),
      child: const FaIcon(
        FontAwesomeIcons.whatsapp,
        size: 40,  // Adjust the icon size
        color: Colors.green,  // Adjust the icon color
      ),
    ),
  ),
),


        ],
      
    );
  }
}
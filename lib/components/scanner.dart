import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  _QRViewExampleState createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorPrimary,
      body: Stack(
        children: <Widget>[
           Center(
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 
                    
                    Image.asset("assets/logo/appname.png",height: 100,width: 200,),
                    const SizedBox(height: 30,),
                   Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                      color: appColorPrimary,borderRadius: BorderRadius.circular(16)),
                      child: QRView(
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                       
                      ),
                    ),
                  
                 const SizedBox(height: 20,),
                  const Text("Looking for valid coupon codes",style: TextStyle(color: appColorAccent ,fontSize: 18,fontWeight:FontWeight.bold ),),
                ],
              
                       ),
           )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    // Listen for scanned data
    controller.scannedDataStream.listen(
      (scanData) async {
        // Handle scanned data
        print('QR Code scanned: ${scanData.code}');
        
        // Fetch current data based on the scanned QR code (assuming it is an ID or reference)
        var currentData = await fetchDataFromDatabase(scanData.code);
        
        // Navigate to a new screen with the fetched data
        if (currentData != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DataDisplayScreen(data: currentData),
            ),
          );
        }

        // Optionally, stop scanning after a successful scan
        controller.pauseCamera();

        // Show a snackbar or dialog to inform the user of the scanned data
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Scanned: ${scanData.code}'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      onError: (error) {
        // Handle error
        print('Error scanning QR code: $error');

        // Optionally, show an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error scanning QR code: $error'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }

  // Example function to fetch data from your database
  Future<Map<String, dynamic>?> fetchDataFromDatabase(String? scannedCode) async {
    // Replace this with your actual data fetching logic, e.g., Firebase Firestore
    try {
      // Dummy return for demonstration
      if (scannedCode != null) {
        return {'id': scannedCode, 'name': 'Sample Name', 'info': 'Sample Info'};
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null; // Handle error appropriately
    }
  }
}

// Moved DataDisplayScreen to top level
class DataDisplayScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const DataDisplayScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Display'),
      ),
      body: Center(
        child: Text(
          'Fetched Data:\n${data.toString()}', // Customize your data display
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}


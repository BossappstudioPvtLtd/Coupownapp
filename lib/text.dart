import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:country_picker/country_picker.dart';



class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController phoneController = TextEditingController();
  String selectedCountryCode = "+91"; // Default country code for India
  String verificationId = "";
  bool isVerifying = false;

  void sendOTP() async {
    setState(() {
      isVerifying = true;
    });

    // Format phone number
    final String phoneNumber = '$selectedCountryCode${phoneController.text.trim()}';

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval or instant verification
          await _auth.signInWithCredential(credential);
          Navigator.push(context, MaterialPageRoute(builder: (_) => VerifyOtpScreen()));
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            isVerifying = false;
          });
          // Handle error here
          print('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            this.verificationId = verificationId;
            isVerifying = false;
          });
          // Navigate to OTP verification screen
          Navigator.push(context, MaterialPageRoute(builder: (_) => VerifyOtpScreen(verificationId: verificationId)));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            this.verificationId = verificationId;
            isVerifying = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        isVerifying = false;
      });
      print('Error sending OTP: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone OTP Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        onSelect: (country) {
                          setState(() {
                            selectedCountryCode = '+${country.phoneCode}';
                          });
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(selectedCountryCode),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Enter phone number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (phoneController.text.length == 10) {
                  sendOTP();
                } else {
                  print('Please enter a valid 10-digit mobile number.');
                }
              },
              child: isVerifying ? const CircularProgressIndicator() : const Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

class VerifyOtpScreen extends StatelessWidget {
  final String? verificationId;

  VerifyOtpScreen({super.key, this.verificationId});

  final TextEditingController otpController = TextEditingController();

  void verifyOtp(BuildContext context) async {
    final String otp = otpController.text.trim();

    if (otp.isNotEmpty) {
      try {
        final AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: otp);
        await FirebaseAuth.instance.signInWithCredential(credential);
        // Navigate to the next screen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SuccessScreen()));
      } catch (e) {
        print('Error verifying OTP: $e');
      }
    } else {
      print('Please enter the OTP.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => verifyOtp(context),
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Success')),
      body: const Center(child: Text('OTP Verification Successful!')),
    );
  }
}

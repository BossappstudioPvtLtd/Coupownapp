
import 'package:coupown/Screanes/bottam_nav.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/text_edit.dart';


class VerifyOtp extends StatefulWidget {
  
  final String? verificationId;
  const VerifyOtp({super.key,  this.verificationId});
  
  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> with SingleTickerProviderStateMixin {

String verificationId = "";
void verifyOtp(BuildContext context) async {
    final String otp = otpController.text.trim();

    if (otp.isNotEmpty) {
      try {
        final AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
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

  // Controllers for each OTP digit input
  final List<TextEditingController> _controllers = List.generate(
    5,
    (index) => TextEditingController(),
  );
   
  final TextEditingController otpController = TextEditingController();
  // Focus nodes to manage focus between text fields
  final List<FocusNode> _focusNodes = List.generate(
    5,
    (index) => FocusNode(),
  );

  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 2.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _slideInAnimation = Tween<Offset>(begin: const Offset(0, 2.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
    _initFocusNodes();
  }

  void _initFocusNodes() {
    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus && _controllers[i].text.isEmpty) {
          // Move to the next field if current field is empty and focused
          if (i < _controllers.length - 1) {
            Future.delayed(const Duration(milliseconds: 100), () {
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
            });
          }
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _controller.dispose();
    super.dispose();
  }

  


  @override
  Widget build(BuildContext context) {
   // final screenHeight = MediaQuery.of(context).size.height;
   // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: appColorPrimary,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated text widgets
            FadeTransition(
              opacity: _fadeInAnimation,
              child: SlideTransition(
                position: _slideInAnimation,
                child: const Column(
                  children: [
                    Textedit(
                      text: "Verify OTP",
                      color: appTextColorPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10),
                    Textedit(
                      text: "Enter the code",
                      color: textColorPrimary,
                    ),
                    SizedBox(height: 10),
                    Textedit(
                      text: "We just sent it to your registered phone",
                      color: textColorPrimary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return SlideTransition(
                  position: _slideInAnimation,
                  child: FadeTransition(
                    opacity: _fadeInAnimation,
                    child: Material(
                      
                          borderRadius: BorderRadius.circular(8),
                      elevation: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: appColorPrimary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: 50,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            if (value.length == 1) {
                              // Move to next field
                              if (index < _controllers.length - 1) {
                                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                              } else {
                                FocusScope.of(context).unfocus();
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),
             MyButtonAni(elevationsize: 10, text: "Verify",onTap:  () async {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const BottamNav()));
                        // Handle OTP verification
                        String otp = _controllers.map((e) => e.text).join();
                        if (otp.length == 5) {
                          // Verify OTP
                          debugPrint('Entered OTP: $otp');
                        } else {
                          // Show error if OTP is incomplete
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please enter the full OTP.')),
                          );
                        }
                      },),
            
            const SizedBox(height: 40),
            
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
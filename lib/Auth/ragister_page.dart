import 'package:country_picker/country_picker.dart';
import 'package:coupown/Screanes/bottam_nav.dart';
import 'package:coupown/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coupown/Auth/facebook.dart';
import 'package:coupown/Auth/verifyde_otp.dart';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/image_add.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Ragisterpage extends StatefulWidget {
  const Ragisterpage({super.key});

  @override
  State<Ragisterpage> createState() => _RagisterpageState();
}

class _RagisterpageState extends State<Ragisterpage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fadeInAnimation;
  late Animation<Offset> slideInAnimation;

  final TextEditingController _codecontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController phoneController = TextEditingController();
  String selectedCountryCode = "+91"; // Default country code for India
  String verificationId = "";
  bool isVerifying = false;


  Country selectedCountry = Country(
    phoneCode: '91',
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'India',
    example: 'India',
    displayName: 'IN',
    displayNameNoCountryCode: 'IN',
    e164Key: "",
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    fadeInAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    slideInAnimation = Tween<Offset>(begin: const Offset(0, 0.9), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    phoneController.dispose();
    super.dispose();
  }





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
          Navigator.push(context, MaterialPageRoute(builder: (_) => const VerifyOtp()));
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
          Navigator.push(context, MaterialPageRoute(builder: (_) => VerifyOtp(verificationId: verificationId)));
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






   Future<void> _signInWithGoogle(BuildContext context) async {
   showCupertinoDialog(
                    context: context,
                    barrierDismissible: false, 
                    builder: (BuildContext context) {
                      return const Loading(text: 'Singin with Google...',);
                      
                      
                    },
                  
);

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        Navigator.pop(context);
        return; // The user canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        _addDataToRealtimeDatabase(user);
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BottamNav()));
      }
    } catch (e) {
      Navigator.pop(context);
      print("Error signing in with Google: $e");
    }
  }

  void _addDataToRealtimeDatabase(User? user) {
    DatabaseReference userRef = FirebaseDatabase.instance.ref().child('Users').child(user!.uid);

    userRef.set({
      'phone': phoneController.text,
      'name': user.displayName ?? 'Anonymous',
      'email': user.email ?? 'No email',
      'id': user.uid,
      'blockStatus': 'no',
    }).then((_) {
      print("User data saved to Realtime Database.");
    }).catchError((error) {
      print("Failed to save user data: $error");
    });
  }


  Future<void> _signInWithApple() async {
    try {
      final appleIDCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'your.client.id',
          redirectUri: Uri.parse('https://your.redirect.uri'),
        ),
      );

      print('User ID: ${appleIDCredential.userIdentifier}');
      print('Email: ${appleIDCredential.email}');
      print('Full Name: ${appleIDCredential.givenName} ${appleIDCredential.familyName}');
      
    } catch (error) {
      print('Error signing in with Apple: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 1000;
    setStatusBarColor(appColorPrimary);


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appColorPrimary,
      body: FadeTransition(opacity: fadeInAnimation,
        child: SlideTransition( position: slideInAnimation,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding( padding: EdgeInsets.symmetric(vertical: screenHeight * 0.06),
                child: Column( children: [
                    Textedit( text: 'Hi, Welcome Back!',color: appTextColorPrimary,fontSize: isSmallScreen ? 18 : 20,fontWeight: FontWeight.bold,),
                    const SizedBox(height: 10),
                    Textedit( text: 'Hope You\'re doing fine',color: iconColorSecondary, fontSize: isSmallScreen ? 14 : 16, fontWeight: FontWeight.w500,),
                  ],
                ),
              ),
             Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            Row(
              children: [
                // Your existing widget code...
                SizedBox(
                  width: screenWidth * 0.3,
                  height: isSmallScreen ? screenHeight * 0.07 : screenHeight * 0.08,
                  child: Card(
                    elevation: 5,
                    color: appColorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.03),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            countryListTheme: const CountryListThemeData(
                              flagSize: 20,
                              bottomSheetHeight: 400,
                            ),
                            onSelect: (country) {
                              setState(() {
                            selectedCountryCode = '+${country.phoneCode}';
                              });
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              '${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: isSmallScreen ? screenHeight * 0.07 : screenHeight * 0.08,
                    child: Card(
                      color: appColorPrimary,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: phoneController,
                          inputFormatters: [LengthLimitingTextInputFormatter(10)],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter phone number',
                            prefixIcon: const Icon(Icons.phone),
                            suffixIcon: phoneController.text.length > 9
                                ? const Icon(Icons.done, color: Colors.green)
                                : null,
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: isSmallScreen ? 14 : 16,
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            MyButtonAni(
              elevationsize: 20,
              text: isVerifying ? 'Sending...' : 'Send OTP',
              onTap: ()  {
                if (phoneController.text.length == 10) {
                  sendOTP();
                } else {
                  print('Please enter a valid 10-digit mobile number.');
                }
              },
            ),
          ],
        ),
      ),






              const SizedBox(height: 30),
              Padding( padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [ const Flexible(child: Divider()),
                    Padding( padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
                    child: Textedit(text: 'Or', fontSize: isSmallScreen ? 12 : 14),),
                    const Flexible(child: Divider()),
                  ],
                ),
              ),
              const SizedBox(height: 20),
             
               Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [ ImageAdd(image: 'assets/logo/google.png',onTap: (){ _signInWithGoogle(context);},),
                  ImageAdd( image: 'assets/logo/facebook.png',
                    onTap: () { Navigator.push(context,MaterialPageRoute(builder: (_) => const Facebook()),);},),
                  ImageAdd( image: 'assets/logo/apple.png',onTap: _signInWithApple,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

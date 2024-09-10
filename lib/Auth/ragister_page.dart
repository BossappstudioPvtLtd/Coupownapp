import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:coupown/Auth/apple_page.dart';
import 'package:coupown/Auth/facebook.dart';
import 'package:coupown/Auth/verifyde_otp.dart';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/image_add.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Ragisterpage extends StatefulWidget {
  const Ragisterpage({super.key});

  @override
  State<Ragisterpage> createState() => _RagisterpageState();
}

class _RagisterpageState extends State<Ragisterpage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fadeInAnimation;
  late Animation<Offset> slideInAnimation;

  final TextEditingController _codecontroller = TextEditingController();
  final phoneController = TextEditingController();
  String phoneNumber = "", data = "";
  String smscode = "";
  final PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'IN');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 1000;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appColorPrimary,
      body: FadeTransition(
        opacity: fadeInAnimation,
        child: SlideTransition(
          position: slideInAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.06),
                child: Column(
                  children: [
                    Textedit(
                      text: 'Hi, Welcome Back!',
                      color: appTextColorPrimary,
                      fontSize: isSmallScreen ? 18 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    Textedit(
                      text: 'Hope You\'re doing fine',
                      color: iconColorSecondary,
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Row(
                  children: [
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
                                onSelect: (value) {
                                  setState(() {
                                    selectedCountry = value;
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
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              keyboardType: TextInputType.number,
                              autofillHints: const [AutofillHints.oneTimeCode],
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
              ),
              const SizedBox(height: 20),
              MyButtonAni(
                elevationsize: 20,
                text: 'Send OTP',
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const VerifyOtp()),
                    );
                  }
                },
              ),
              const SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
                      child: Textedit(text: 'Or', fontSize: isSmallScreen ? 12 : 14),
                    ),
                    const Flexible(child: Divider()),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ImageAdd(image: 'assets/logo/google.png'),
                  ImageAdd(
                    image: 'assets/logo/facebook.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const Facebook()),
                      );
                    },
                  ),
                  ImageAdd(
                    image: 'assets/logo/apple.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ApplePage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

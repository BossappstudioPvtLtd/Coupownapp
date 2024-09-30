import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/subscription/add_product.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String? selectedMethod;

  final paymentMethods = [
    {'name': 'UPI', 'image': 'assets/images/UPI1.png'},
    {'name': 'NetBanking', 'image': 'assets/images/netbanking.png'},
    {'name': 'phonePe', 'image': 'assets/images/PhonePe.png'},
    {'name': 'Google Pay', 'image': 'assets/images/googlepay.png'},
  ];

  // Controllers for the text fields in the dialog
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: appColorPrimary,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
        title: const Text('Select Payment Method'),
        backgroundColor: appColorPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Textedit(
              text: "Payment Method",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Card(
                            color: appColorPrimary,
                elevation: 5,
                child: ListTile(
                  title: const Text(
                    'Credit Card',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Material(
                        color: appColorPrimary,
                        elevation: 2,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Image.asset(
                            'assets/images/credit_card.png',
                            width: isSmallScreen ? 16 : 25,
                            height: isSmallScreen ? 20 : 25,
                          ),
                        ),
                      ),
                      Material(
                        color: appColorPrimary,
                        elevation: 2,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Image.asset(
                            'assets/images/upi.png',
                            width: isSmallScreen ? 16 : 25,
                            height: isSmallScreen ? 20 : 25,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: appColorPrimary,
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Add New Card"),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 28,
                                        width: 28,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black, width: 2),
                                          borderRadius: BorderRadius.circular(32),
                                        ),
                                        child: const Center(
                                          child: Icon(Icons.close, size: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Form(
                                  key: _formKey, // Add Form key
                                  child: SizedBox(
                                    height: 200, // Increased height for better spacing
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                              controller: cardNumberController,
                                              decoration: const InputDecoration(labelText: "Card Number"),
                                              keyboardType: TextInputType.number,
                                              maxLength: 16, // Limit to 16 characters
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter the card number';
                                                }
                                                if (value.length < 16) {
                                                  return 'Card number must be 16 digits';
                                                }
                                                return null; // Valid input
                                              },
                                            ),
                                        TextFormField(
                                          controller: cardHolderController,
                                          decoration: const InputDecoration(labelText: "Card Holder Name"),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter the card holder\'s name';
                                            }
                                            return null; // Valid input
                                          },
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller: expiryDateController,
                                                decoration: const InputDecoration(labelText: "Expiry Date (MM/YY)"),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter the expiry date';
                                                  }
                                                  return null; // Valid input
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: TextFormField(
                                                controller: cvvController,
                                                decoration: const InputDecoration(labelText: "CVV"),
                                                keyboardType: TextInputType.number,
                                                maxLength: 3, 
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter CVV';
                                                  } else if (value.length != 3) {
                                                    return 'CVV must be 3 digits';
                                                  }
                                                  return null; // Valid input
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  MyButtonAni(
                                    elevationsize: 10,
                                    text: "Add Card",
                                    onTap: () {
                                      // Validate the form
                                      if (_formKey.currentState!.validate()) {
                                        // Perform add card action here
                                        Navigator.pop(context);
                                        // Optionally, clear text fields
                                        cardNumberController.clear();
                                        cardHolderController.clear();
                                        expiryDateController.clear();
                                        cvvController.clear();
                                      }
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: const Card(
                          color: appColorPrimary,
                          child: SizedBox(
                            width: 60,
                            height: 40,
                            child: Center(
                              child: Text(
                                "Add",
                                style: TextStyle(color: appColorAccent, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  leading: Radio<String>(
                    hoverColor: appColorAccent,
                    activeColor: appColorAccent,
                    focusColor: appColorAccent,
                    value: 'Credit Card',
                    groupValue: selectedMethod,
                    onChanged: (value) => setState(() => selectedMethod = value),
                  ),
                ),
              ),
            ),
            ...paymentMethods.map((method) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Card(
                            color: appColorPrimary,

                    elevation: 5,
                    child: ListTile(
                      title: Text(
                        method['name'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                      trailing: Material(elevation: 5,
                      
                      borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: appColorPrimary,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Image.asset(
                            method['image'] as String,
                            width: isSmallScreen ? 50 : 40,
                            height: isSmallScreen ? 30 : 40,
                          ),
                        ),
                      ),
                      leading: Radio<String>(
                        hoverColor: appColorAccent,
                        activeColor: appColorAccent,
                        focusColor: appColorAccent,
                        value: method['name'] as String,
                        groupValue: selectedMethod,
                        onChanged: (value) => setState(() => selectedMethod = value),
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 50),
            MyButtonAni(
              elevationsize: 10,
              text: "Pay Now",
              onTap: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddProduct(),
                    ),
                  );
                if (selectedMethod != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentConfirmationPage(method: selectedMethod!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a payment method')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}




class PaymentConfirmationPage extends StatelessWidget {
  final String method;

  const PaymentConfirmationPage({super.key, required this.method});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Confirmation')),
      body: Center(
        child: Text('You have selected: $method', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}

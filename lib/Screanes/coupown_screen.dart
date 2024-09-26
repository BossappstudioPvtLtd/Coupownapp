import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String? selectedMethod;

  final paymentMethods = [
    {'name': 'Credit Card', 'icon': Icons.credit_card},
    {'name': 'UPI', 'icon': Icons.account_balance},
    {'name': 'NetBanking', 'icon': Icons.computer},
    {'name': 'PayTm', 'icon': Icons.money},
    {'name': 'Google Pay', 'icon': Icons.payments},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorPrimary,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
        title: const Text('Select Payment Method'),
        backgroundColor: appColorPrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Textedit(
              text: "Payment Method",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...paymentMethods.map((method) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  child: ListTile(
                    title: Text(method['name'] as String,style: const TextStyle(fontWeight:FontWeight.bold ),),
                    trailing: Icon(method['icon'] as IconData, color: appColorAccent),
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
          )
        ],
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

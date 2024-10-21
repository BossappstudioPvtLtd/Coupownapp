import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:flutter/material.dart';

class PriceIncreaseBar extends StatefulWidget {
  const PriceIncreaseBar({super.key});

  @override
  _PriceIncreaseBarState createState() => _PriceIncreaseBarState();
}

class _PriceIncreaseBarState extends State<PriceIncreaseBar> {
  double _currentPrice = 0.0; // Initial price value
  final TextEditingController _startPriceController = TextEditingController();
  final TextEditingController _endPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text fields with initial values
    _startPriceController.text = '0';
    _endPriceController.text = '0';
  }

  void _updatePriceFromTextField(String value) {
    double? newValue = double.tryParse(value);
    if (newValue != null && newValue >= 0.0) {
      setState(() {
        _currentPrice = newValue;
      });
    }
  }

  void _updateStartPriceFromTextField(String value) {
    double? newValue = double.tryParse(value);
    if (newValue != null && newValue >= 0.0) {
      setState(() {
        _currentPrice = newValue; // Update current price based on start price input
      });
    }
  }

  void _updateEndPriceFromTextField(String value) {
    double? newValue = double.tryParse(value);
    if (newValue != null && newValue >= _currentPrice) {
      setState(() {
        _endPriceController.text = value; // Only update end price if it is greater than or equal to current price
      });
    }
  }

  void _updatePriceFromSlider(double value) {
    setState(() {
      _currentPrice = value;
      _startPriceController.text = _currentPrice.toStringAsFixed(2);
    });
  }

  void _applyPriceFilter() {
    double startPrice = double.tryParse(_startPriceController.text) ?? 0.0;
    double endPrice = double.tryParse(_endPriceController.text) ?? 0.0;

    // Add your filtering logic here
    // For example, you could call a method to filter items based on startPrice and endPrice
    print("Applying filter: Start Price: ₹$startPrice, End Price: ₹$endPrice");
    // Perform any actions needed to apply the filter
  }

  // Method to create a row of text fields for start and end prices
  Widget _buildPriceTextFieldRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Card(
            color: appColorPrimary,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                controller: _endPriceController,
                decoration: const InputDecoration(
                  border: InputBorder.none, // Remove border
                  prefixText: '₹ ', // Currency symbol on the left
                ),
                keyboardType: TextInputType.number,
                onChanged: _updateEndPriceFromTextField,
              ),
            ),
          ),
        ),
        const Text(
          '-',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        Expanded(
          child: Card(
            color: appColorPrimary,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                controller: _startPriceController,
                decoration: const InputDecoration(
                  border: InputBorder.none, // Remove border
                  prefixText: '₹ ', // Currency symbol on the left
                ),
                keyboardType: TextInputType.number,
                onChanged: _updateStartPriceFromTextField,
              ),
            ),
          ),
        ),
        // Space between text fields
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: appColorPrimary,
              ),
              height: 200, // Increased height to fit the button
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Price:',
                      style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),
                    ), // Use the method to build text field row
                    const Spacer(),
                    Slider(
                      thumbColor: appColorAccent,
                      activeColor: appColorAccent,
                      value: _currentPrice,
                      min: 0.0,
                      max: 1000.0, // Adjust maximum value as needed
                      divisions: 100,
                      label: '₹${_currentPrice.toStringAsFixed(2)}',
                      onChanged: _updatePriceFromSlider,
                    ),
                    _buildPriceTextFieldRow(),

    ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30,),
          SmallButton(onTap: _applyPriceFilter,elevationsize:  10, text: "Apply",textcolor: appColorPrimary,containerheight: 40,containerwidth: double.infinity,borderRadius: BorderRadius.circular(32),meterialColor:appColorAccent),
 const SizedBox(height: 30,),
        ],
      ),
    );
  }
}

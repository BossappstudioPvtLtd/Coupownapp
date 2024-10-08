import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:intl/intl.dart';

class BookingStepper extends StatefulWidget {
  
  const BookingStepper({Key? key}) : super(key: key);

  @override
  _BookingStepperState createState() => _BookingStepperState();
}

class _BookingStepperState extends State<BookingStepper> {
  int activeStep = 0;
  final PageController _pageController = PageController();
  String selectedAddress = ''; // Store selected address
  String selectedDate = ''; // Store selected date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorPrimary,
      
      body: Column(
        children: [
          // Easy Stepper
        const Padding(
          padding: EdgeInsets.only(left: 20,top: 30),
          child: MyAppbar(text: "Book Your Slot"),
        ),
          SizedBox(
          height: 90,
            child: EasyStepper(
              
              activeStep: activeStep,
              stepRadius: 20,
              internalPadding: 50,
              stepShape: StepShape.circle,
              stepBorderRadius: 30,
              borderThickness: 2,
              unreachedStepBorderColor: appColorAccent,
              finishedStepBorderColor: appColorPrimary,
              finishedStepTextColor: appTextColorPrimary,
              finishedStepBackgroundColor: appColorAccent,
              activeStepIconColor: appColorPrimary,
              activeStepBorderColor: Colors.blueGrey,
              activeStepBackgroundColor: Colors.blueGrey,
              activeStepTextColor: appTextColorPrimary,
              unreachedStepIconColor:appLight_orange,
              
              steps: const [
                EasyStep(
                  icon: Icon(Icons.location_on, color: appColorAccent),
                  title: 'Select\nAddress',
                ),
                EasyStep(
                  icon: Icon(Icons.access_time, color: appColorAccent),
                  title: 'Select\nTimeslot',
                ),
                EasyStep(
                  icon: Icon(Icons.check_circle_outline, color: appColorAccent),
                  title: 'Booking\nSummary',
                ),
              ],
              onStepReached: (index) {
                setState(() {
                  activeStep = index;
                  _pageController.jumpToPage(index); // Jump to the selected step
                });
              },
            ),
          ),

          // PageView for sliding between steps
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
                children: [
                  AddressForm(
                    onAddressSelected: (address) {
                      setState(() {
                        selectedAddress = address; // Update selected address
                      });
                    },
                  ),
                  TimeslotForm(
                    onDateSelected: (date) {
                      setState(() {
                        selectedDate = date; // Update selected date
                      });
                    },
                  ),
                  BookingSummary(
                    address: selectedAddress,
                    date: selectedDate,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  // Bottom navigation buttons (Back)
 Widget bottomNavigationBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      
        

           Padding(
             padding: const EdgeInsets.only(left: 25,bottom: 10),
             child: MyButtonAni(
              containerheight: 40,
              containerwidth: 270,
              elevationsize: 20,
              text: activeStep == 0
                  ? 'Select Timeslot'
                  : activeStep == 1
                      ? 'Confirm Booking'
                      : 'Book Offer',
              onTap: () async {
                if (activeStep < 2) {
                  setState(() {
                    activeStep++;
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  });
                } else {
                  // Show loader when booking is being processed
                 
                  showCupertinoDialog(
                    context: context,
                    barrierDismissible: false, 
                    builder: (BuildContext context) {
                      return const CupertinoAlertDialog(
                        content: Row(
                          children: [
                            CupertinoActivityIndicator(), 
                            SizedBox(width: 20), 
                            Text("Booking in Progress..."),
                          ],
                        ),
                      );
                    },
                  );
                       
                  // Simulate a delay for booking confirmation (e.g., API call)
                  await Future.delayed(const Duration(seconds: 2));
                       
                  // Hide the loader
                  Navigator.of(context).pop();
                       
                  // Final submission or confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Booking Confirmed!')),
                  );
                }
              },
                       
                  ),
           ),
        
    ],
  );
}

}


  


// Step 1: Address Form
class AddressForm extends StatefulWidget {
  const AddressForm({super.key, required this.onAddressSelected});

  final Function(String address) onAddressSelected; // Callback for address selection

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  String selectedValue = "Name"; // To track the selected radio button value
  final String phoneNumber = "+91 98413XXXXX"; // Add phone number
  String address =
      "+91 98413XXXXX \nRoys Complex, Puthukottai, Tuticorin Main Road, Tuticorin, Tuticorin Main Road, Tuticorin"; // Address (can be edited)

  // Function to show the dialog and edit the address
 void _editAddress(BuildContext context) {
  TextEditingController addressController = TextEditingController(text: address);

  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text('Edit Address'),
        content: Column(
          children: [
            const SizedBox(height: 16),
            const Text('Please enter the new address:'),
            const SizedBox(height: 16),
            CupertinoTextField(
              controller: addressController,
              placeholder: 'Enter new address',
              maxLines: 6,
              padding: const EdgeInsets.all(12),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Save'),
            onPressed: () {
              setState(() {
                address = addressController.text; // Update the address
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Radio Button for selecting address type
            Radio(
              value: "Name",
              activeColor: appColorAccent,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!; // Update the selected value
                });
              },
            ),
            const Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 10), // Spacer between text and other widgets
            const Text('Home', style: TextStyle(fontWeight: FontWeight.bold, color: appColorAccent)),
            const Spacer(),
            // Edit Button for editing the address
            IconButton(
              icon: const Icon(Icons.edit_square),
              onPressed: () {
                _editAddress(context); // Call function to show address edit dialog
              },
            ),
          ],
        ),
        const SizedBox(height: 20), // Spacing before address details
        // Address Display with Radio Button
        Padding(
          padding: const EdgeInsets.only(left: 1),
          child: Row(
            children: [
              // Radio Button for the address
              Radio(
                value: address, // Current address
                groupValue: selectedValue, // The selected value
                activeColor: appColorAccent,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!; // Update selected address
                    widget.onAddressSelected(address); // Trigger callback
                  });
                },
              ),
              // Address text
              Expanded(
                child: Column(
                  children: [
                    Text(
                      address,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: appTextColorSecondary,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// Step 2: Timeslot Form
class TimeslotForm extends StatefulWidget {
  const TimeslotForm({super.key, required this.onDateSelected});

  final Function(String date) onDateSelected; // Callback for date selection

  @override
  _TimeslotFormState createState() => _TimeslotFormState();
}

class _TimeslotFormState extends State<TimeslotForm> {
  late String selectedMonth;
  late String selectedDate;

  final Map<String, String> months = {
    'January': 'Jan',
    'February': 'Feb',
    'March': 'Mar',
    'April': 'Apr',
    'May': 'May',
    'June': 'Jun',
    'July': 'Jul',
    'August': 'Aug',
    'September': 'Sep',
    'October': 'Oct',
    'November': 'Nov',
    'December': 'Dec',
  };

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    selectedMonth = now.month == 1 ? 'January' : months.keys.elementAt(now.month - 1);
    selectedDate = DateFormat('EEE, MMM d').format(now); // Format current date
  }

  List<String> getDatesForMonth(String? month) {
    if (month == null) return [];
    int monthIndex = months.keys.toList().indexOf(month) + 1;
    int currentYear = DateTime.now().year;

    List<String> dates = [];
    int daysInMonth = DateTime(currentYear, monthIndex + 1, 0).day; // Get number of days in the month

    // Get today's date
    DateTime today = DateTime.now();

    for (int day = 1; day <= daysInMonth; day++) {
      DateTime date = DateTime(currentYear, monthIndex, day);
      
      // Only add dates that are today or in the future
      if (date.isAtSameMomentAs(today) || date.isAfter(today)) {
        String formattedDate = DateFormat('EEE, MMM d').format(date); // Short day name
        dates.add(formattedDate);
      }
    }

    // Move today's date to the first position if it's in the selected month
    if (today.month == monthIndex) {
      String todayFormatted = DateFormat('EEE, MMM d').format(today);
      if (dates.contains(todayFormatted)) {
        dates.remove(todayFormatted); // Remove today's date if it exists
        dates.insert(0, todayFormatted); // Add it to the front
      }
    }

    return dates;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Timeslot',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: DropdownButtonFormField<String>(
            menuMaxHeight: 400,
            borderRadius: BorderRadius.circular(16),
            dropdownColor:appColorPrimary,
            decoration: const InputDecoration(labelText: 'Select a Month',),
            value: selectedMonth,
            items: months.keys.map((String month) {
              return DropdownMenuItem<String>(
                
                value: month,
                child: Text('$month (${months[month]})'),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedMonth = newValue!;
                selectedDate = ''; // Reset selected date when changing month
              });
            },
          ),
        ),
        const SizedBox(height: 20),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: getDatesForMonth(selectedMonth).map((date) {
              bool isSelected = date == selectedDate;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDate = date; // Update selected date
                    widget.onDateSelected(selectedDate); // Trigger the callback to send date
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blueGrey : Colors.white,
                      border: Border.all(
                        color: isSelected ? appColorPrimary : appColorAccent, // Change border color based on selection
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: date.split(' ')[0], // First part of the date
                              style: TextStyle(fontSize: 20, color: isSelected ? Colors.white : Colors.black),
                            ),
                            const TextSpan(text: '\n'), // Line break
                            TextSpan(
                              text: date.split(' ')[1], // Text for the new line
                              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                            ),
                            const TextSpan(text: ''), // Line break
                            TextSpan(
                              text: date.split(' ')[2], // Third part of the date
                              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

// Booking Summary




class BookingSummary extends StatefulWidget {
  const BookingSummary({super.key, required this.address, required this.date});

  final String address; // Selected address
  final String date; // Selected date

  @override
  _BookingSummaryState createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  late String address;

  @override
  void initState() {
    super.initState();
    address = widget.address; // Initialize address with the widget's address
  }

  void _editAddress(BuildContext context) {
    TextEditingController addressController = TextEditingController(text: address);

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Edit Address'),
          content: Column(
            children: [
              const SizedBox(height: 16),
              const Text('Please enter the new address:'),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: addressController,
                placeholder: 'Enter new address',
                maxLines: 6,
                padding: const EdgeInsets.all(12),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Cancel',style: TextStyle(color: appDarkRed),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Save',style: TextStyle(color: appDark_parrot_green),),
              onPressed: () {
                setState(() {
                  address = addressController.text; // Update the address
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCouponSavedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AnimatedDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define service amount and coupon discount
    const double serviceAmount = 50.0;
    const double couponDiscount = 10.0;

    // Calculate total amount (without GST)
    double totalAmount = (serviceAmount - couponDiscount).clamp(0, double.infinity);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and address section
          const Text(
            'Review & Verify',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Text('Home', style: TextStyle(fontWeight: FontWeight.bold, color:appColorAccent)), // Adjust your accent color
            ],
          ),
          const SizedBox(height: 10),
          Text('Address: $address', style: const TextStyle(fontWeight: FontWeight.bold)),

          // Date selection
          const SizedBox(height: 10),
          Text('Date: ${widget.date}', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          // Change address button
          InkWell(
            onTap: () {
              _editAddress(context);
            },
            splashColor: appColorPrimary,
            borderRadius: BorderRadius.circular(32),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: appColorAccent, width: 1.5), // Adjust your accent color
                borderRadius: BorderRadius.circular(32),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    _editAddress(context);
                  },
                  child: const Text(
                    'Change Address',
                    style: TextStyle(color:appColorAccent), // Adjust your accent color
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Service amount details
          const Text('Service Amount Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Split AC Service', style: TextStyle(fontSize: 14)),
              Text('₹${serviceAmount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Coupon Discount', style: TextStyle(fontSize: 14)),
              Text('- ₹${couponDiscount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 14, color: Colors.green)),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 1),
          const SizedBox(height: 10),

          // Total amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text('₹${totalAmount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 40),

          // Coupon input and Save button
          Center(
            child: SmallButton(
              elevationsize: 10,
              text: "Save Coupon",
              containerheight: 40,
              containerwidth: 150,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              onTap: () {
                _showCouponSavedDialog(context); // Show the dialog on button tap
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedDialog extends StatefulWidget {
  const AnimatedDialog({super.key});

  @override
  _AnimatedDialogState createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Repeat the animation with reverse
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: appColorPrimary,
      contentPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Container(
        color: appColorPrimary,
        height: 200, // Set your desired height here
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog when pressed
                },
              ),
            ),
            ScaleTransition(
              scale: _animation,
              child: const CircleAvatar(
                radius: 25,
                backgroundColor: appColorAccent,
                child: Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            const Text(
              "Coupon saved successfully!",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

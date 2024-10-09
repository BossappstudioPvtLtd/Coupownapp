import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  // Sample list of notifications
  final List<Map<String, String>> notifications = [
    // Uncomment the following lines to test the "No Data" message
     {'title': 'New Message', 'subtitle': 'You have received a new message'},
     {'title': 'Update Available', 'subtitle': 'A new update is available'},
     {'title': 'Reminder', 'subtitle': 'Your event is coming up soon'},
     {'title': 'New Offer', 'subtitle': 'Special offer just for you!'},
     {'title': 'New Message', 'subtitle': 'You have received a new message'},
     {'title': 'Update Available', 'subtitle': 'A new update is available'},
     {'title': 'Reminder', 'subtitle': 'Your event is coming up soon'},
     {'title': 'New Offer', 'subtitle': 'Special offer just for you!'},
     {'title': 'New Message', 'subtitle': 'You have received a new message'},
     {'title': 'Update Available', 'subtitle': 'A new update is available'},
     {'title': 'Reminder', 'subtitle': 'Your event is coming up soon'},
     {'title': 'New Offer', 'subtitle': 'Special offer just for you!'},
  ];

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorPrimary,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 20),
            child: MyAppbar(text: "Notifications"),
          ),
          Expanded(
            child: notifications.isEmpty
                ? Center(
                    child: Text(
                      'No Notifications Available',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600], // Color for the no data message
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      // Safely access the notification
                      if (index < notifications.length) {
                        final notification = notifications[index];
                        return Dismissible(
                          key: Key(notification['title']!),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: appColorAccent,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (direction) {
                            // Handle the deletion of the notification
                            notifications.removeAt(index);

                            // Show a snackbar after deleting
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${notification['title']} dismissed'),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: Material(
                              color: appColorPrimary,
                              elevation: 10,
                              borderRadius: BorderRadius.circular(8),
                              child: ListTile(
                                leading: Container(
                                  width: 50,
                                  height: 50, // Set the height of the container
                                  decoration: BoxDecoration(
                                    color: appColorAccent, // Background color
                                    borderRadius: BorderRadius.circular(8), // Rounded corners
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8.0,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.percent,
                                          // Size of the icon
                                          color: Colors.white, // Icon color
                                        ),
                                        SizedBox(height: 8), // Space between icon and text
                                      ],
                                    ),
                                  ),
                                ),
                                title: Text(notification['title']!),
                                subtitle: Text(notification['subtitle']!),
                                trailing: const Icon(Icons.arrow_forward),
                                onTap: () {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        title: Text(notification['title']!),
                                        content: Text(notification['subtitle']!),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            child: const Text('Close'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text(
                            '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red, // Color for the error message
                            ),
                          ),
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

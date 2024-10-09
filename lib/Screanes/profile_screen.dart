import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';  // For handling file types



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorPrimary,
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Textedit(
            text: "Profile",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: appTextColorPrimary,
          ),
          const SizedBox(height: 20),
          
          // Centered CircleAvatar for profile image with image picker
         Center(
  child: Stack(
    children: [
      // CircleAvatar for profile image
      CircleAvatar(
        radius: 50,
        backgroundImage: _imageFile != null
            ? FileImage(_imageFile!)  // Display the picked image
            : const NetworkImage('https://via.placeholder.com/150')
                as ImageProvider, // Placeholder image
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: GestureDetector(
          onTap: _pickImage,  // On tap, it will open the gallery
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: appColorAccent,  // Background color for the camera icon
            ),
            padding: const EdgeInsets.all(6),
            child: const Icon(
              Icons.edit,
              size: 20,
              color: Colors.white,  // Icon color
            ),
          ),
        ),
      ),
    ],
  ),
),

          
          const SizedBox(height: 10),
          // Profile Name
          const Text(
            'John Doe',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text(
            '+91 9841355844',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),
          
          // ListTiles
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.person_4_outlined,),
                  title: const Text('Edit Profile'),
                  trailing: const Icon(Icons.arrow_forward_ios, ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.settings_outlined, ),
                  title: const Text('Settings'),
                  trailing: const Icon(Icons.arrow_forward_ios,),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline,),
                  title: const Text('Help and Support'),
                  trailing: const Icon(Icons.arrow_forward_ios, ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.article_outlined, ),
                  title: const Text('Terms and Conditions'),
                  trailing: const Icon(Icons.arrow_forward_ios, ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.logout_outlined, ),
                  title: const Text('Log Out'),
                  trailing: const Icon(Icons.arrow_forward_ios,),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

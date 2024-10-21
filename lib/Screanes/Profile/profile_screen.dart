import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/Profile/help.dart';
import 'package:coupown/Screanes/Profile/edit_profile.dart';
import 'package:coupown/Screanes/Profile/setting.dart';
import 'package:coupown/Screanes/Profile/terms_conditions.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:coupown/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


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
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Loading(text: 'Logout...'),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog( backgroundColor: appColorPrimary,
        title: const Center( child: Text('Logout', style: TextStyle(color: appColorAccent, fontWeight: FontWeight.bold)),),
        content: const Column(mainAxisSize: MainAxisSize.min,
          children: [Divider(), Padding(padding: EdgeInsets.symmetric(vertical: 10.0), child: Text('Are you sure you want to log out?'))],),
        actions: [
          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Expanded(child: TextButton(onPressed: () => Navigator.pop(context),
                 style: TextButton.styleFrom(backgroundColor: const Color.fromARGB(255, 243, 244, 254)),child: const Text('Cancel', style: TextStyle(color: appColorAccent),
               )
             ),
           ),
       const SizedBox(width: 10),
              Expanded(child: ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: appColorAccent),
                  onPressed: () async { Navigator.pop(context); await _signOut();},
                  child: const Text('Yes, Logout', style: TextStyle(color: appColorPrimary)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorPrimary,
      body: Column(
        children: [
          const SizedBox(height: 50),
           
          const Textedit(text: "Profile", fontSize: 20, fontWeight: FontWeight.bold, color: appTextColorPrimary),
          const SizedBox(height: 20),
          // Center( child: Stack(children: [ Shimmer.fromColors(
          //     baseColor: Colors.grey[300]!,
          //     highlightColor: Colors.grey[100]!,
          //   child: CircleAvatar(radius: 50,
          //    backgroundImage: _imageFile != null ? FileImage(_imageFile!) as ImageProvider<Object> : const NetworkImage('https://via.placeholder.com/150') as ImageProvider<Object>,
          //    ),
          // ),
           Center( child: Stack(children: [
             CircleAvatar(radius: 50,
             backgroundImage: _imageFile != null ? FileImage(_imageFile!) as ImageProvider<Object> : const NetworkImage('https://via.placeholder.com/150') as ImageProvider<Object>,
             ),
          

          Positioned( bottom: 0, right: 0,
                  child: GestureDetector( onTap: _pickImage,child: Container( padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: appColorAccent, borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Icon(Icons.edit, size: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text('John Doe', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Text('+91 9841355844', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 30),
          Expanded(child: ListView(
              children: [
                _buildListTile('Edit Profile', Icons.person_4_outlined,  EditProfile()),
                _divider(),
                _buildListTile('Settings', Icons.settings_outlined, const Setting()),
                _divider(),
                _buildListTile('Help and Support', Icons.help_outline, const HelpSuport()),
                _divider(),
                _buildListTile('Terms and Conditions', Icons.article_outlined, const TermsConditions()),
                _divider(),
                ListTile( leading: const Icon(Icons.logout_outlined), title: const Text('Log Out'), trailing: const Icon(Icons.arrow_forward_ios),onTap: _showLogoutDialog,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildListTile(String title, IconData icon, Widget screen) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
    );
  }

  Widget _divider() => const Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Divider());
}

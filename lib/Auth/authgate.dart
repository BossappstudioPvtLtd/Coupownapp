
import 'package:coupown/Auth/ragister_page.dart';
import 'package:coupown/Screanes/bottam_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Authgate extends StatelessWidget {
  const Authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshort) {
          if (snapshort.hasData) {
            return  const BottamNav();
          } else {
            return const Ragisterpage ();
          }
        },
      ),
    );
  }
}

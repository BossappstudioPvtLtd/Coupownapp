import 'package:coupown/onboding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
     options: const FirebaseOptions(
      apiKey: 'AIzaSyCn5kwYLdbw6oZZyK2mQmVbw5vXLw0i4oY',
      appId: '1:565852755125:android:0fe8ac3ed1feccc1a8dafc',
      messagingSenderId: '565852755125',
      projectId: 'coupown-b4b84',
      authDomain: 'coupown-b4b84.firebaseapp.com',
      storageBucket: 'coupown-b4b84.appspot.com',
    ),
  );
  // Lock screen orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp(
    
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coupown App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnBoarding(), // Set OnBoarding page as the home
    );
  }
}





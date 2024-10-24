import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignInMethods {
  

  static Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    log(loginResult.accessToken!.tokenString.toString());
    log(loginResult.message.toString());

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    log(userCredential.additionalUserInfo!.username.toString());
    log(userCredential.user!.email.toString());
    log(userCredential.user!.photoURL.toString());
    return userCredential;
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Rivepod/loginpart/screen/LoginScreen.dart';
import 'package:flutter_application_1/Rivepod/screen/realtimescreen/post_screen.dart';


// class SplasgServices {
// void isLogin(BuildContext context){

// final auth = FirebaseAuth.instance;
// final user = auth.currentUser;

// if(user!=null){
//  Timer(Duration(seconds: 3),
//     ()=> 
//     Navigator.push
//    (context, MaterialPageRoute(builder: (context)=>
//   PostScreen())));
// }else{
//    Timer(Duration(seconds: 3),
//     ()=> 
//     Navigator.push
//    (context, MaterialPageRoute(builder: (context)=>
//    LoginScreen())));
// }

   
  
// }


// }

class SplasgServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    Timer(
      const Duration(seconds: 3),
      () {
        if (!context.mounted) return;

        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const PostScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
          );
        }
      },
    );
  }
}
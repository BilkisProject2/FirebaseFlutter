import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Rivepod/screen/realtimescreen/post_screen.dart';
import 'package:flutter_application_1/auth/login_screen.dart';

class SplasgServices {
void isLogin(BuildContext context){

final auth = FirebaseAuth.instance;
final user = auth.currentUser;

if(user!=null){
 Timer(Duration(seconds: 3),
    ()=> 
    Navigator.push
   (context, MaterialPageRoute(builder: (context)=>
  PostScreen())));
}else{
   Timer(Duration(seconds: 3),
    ()=> 
    Navigator.push
   (context, MaterialPageRoute(builder: (context)=>
   LoginScreen())));
}

   
  
}


}
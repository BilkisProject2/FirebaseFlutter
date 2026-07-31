import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/Utils/utils.dart';
import 'package:flutter_application_1/auth/verfied_by_otp.dart';
import 'package:flutter_application_1/widgets/RoundButton.dart';

class LoginWithPhonenuber extends StatefulWidget {
  const LoginWithPhonenuber({super.key});

  @override
  State<LoginWithPhonenuber> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginWithPhonenuber> {
  final phonenumberContoller = TextEditingController();
   bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN WITH PHONE NUMBER"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
        TextField(
          controller: phonenumberContoller,
           keyboardType:TextInputType.phone,
          decoration: InputDecoration(
            hintText: "+ 91 908365353",
           
            prefixIcon: Icon(Icons.call),
            helperText: "ENTER YOUR PHONE NUMBER THERE TO CHECK"
          ),
        ),

        SizedBox(height: 50,),
        Roundbutton(title:  "LOGIN WITH OTP",
        loading: loading
        , onTap: (){
          setState(() {
            loading=true;
          });
          auth.verifyPhoneNumber(
            phoneNumber: phonenumberContoller.text,
            verificationCompleted: (_){
 setState(() {
            loading=false;
          });
            }, 
            verificationFailed: (e){
              Utils().toastMessage(e.toString());
            },
             codeSent: (String verification,int? toaken){
Navigator.push(context, MaterialPageRoute(
  builder: (context)=> VerfiedByOtp(verfiationid: verification,)));
   setState(() {
            loading=true;
          });
             },
              codeAutoRetrievalTimeout: (e){
                Utils().toastMessage(e.toString());
              });

        })
          ],
        ),
      ),
    );
  }
}
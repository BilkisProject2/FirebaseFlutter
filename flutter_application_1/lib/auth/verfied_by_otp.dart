import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/posts/post_screen.dart';
import 'package:flutter_application_1/widgets/RoundButton.dart';

class VerfiedByOtp extends StatefulWidget {
 final  String  verfiationid;
 const  VerfiedByOtp({Key? key, 
  required this.verfiationid}):super(key: key);

  @override
  State<VerfiedByOtp> createState() => _VerfiedByOtp();
}

class _VerfiedByOtp extends State<VerfiedByOtp> {
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
            hintText: "6 digit code",
            prefixIcon: Icon(Icons.call),
          ),
        ),

        SizedBox(height: 50,),
        Roundbutton(title:  "VERIFY OTP",
        loading: loading
        , onTap: () async{
      
final credital = PhoneAuthProvider.
credential(verificationId: 
widget.verfiationid, 
smsCode: phonenumberContoller.text.toString());

try{
await auth.signInWithCredential(credital);
Navigator.push(context, MaterialPageRoute(builder: (context)=>
PostScreen()));
}catch(e){

}
        })
          ],
        ),
      ),
    );
  }
}
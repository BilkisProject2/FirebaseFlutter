// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/widgets/RoundButton.dart';

// class ForgotPassword extends StatefulWidget {
//   const ForgotPassword({super.key});

//   @override
//   State<ForgotPassword> createState() => _ForgotPasswordState();
// }

// class _ForgotPasswordState extends State<ForgotPassword> {
//   final emailController = TextEditingController();
//   final _auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Forgot Password"),
//       ),
//       body:   Column(
//         children: [
//           TextFormField(controller:emailController,
//           decoration:InputDecoration(
//             hintText: "Email",
//             border: OutlineInputBorder(),
//           )
//           ),
//           SizedBox(height: 20,),
//         Roundbutton(title: "Forgot Password", onTap: (){
//           _auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email Sent")));
//           }).onError((error, stackTrace){
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
//           });

//         })
//         ],
//       )
//     );
//   }
// }
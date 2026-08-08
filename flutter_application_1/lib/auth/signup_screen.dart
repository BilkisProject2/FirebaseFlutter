// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/ui/Utils/utils.dart';
// import 'package:flutter_application_1/auth/login_screen.dart';
// import 'package:flutter_application_1/widgets/RoundButton.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<SignupScreen> {

// bool loading=false;
// final _formkey = GlobalKey<FormState>();
// final emailController = TextEditingController();
// final passwordController = TextEditingController();
// FirebaseAuth auth = FirebaseAuth.instance;


// void singupcode(){
//   setState(() {
//                   loading=true;
//                 });
//        auth.createUserWithEmailAndPassword(email: emailController.text.toString(),
//         password: passwordController.text.toString()).then((value){
// setState(() {
//                   loading=false;
//                 });
//         }).onError((Error, StackTrace){
// Utils().toastMessage(Error.toString());
// setState(() {
//   loading=false;
// });
//         });
// }

// @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
// appBar: AppBar(
//   title: Text("Bilkis"),
// ),
// body: Padding(
//   padding: const EdgeInsets.all(20.0),
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.stretch,
//     children: [
//       Form(
//         key:_formkey,
//         child:  Column(
//           children: [
//           TextFormField(
//             controller: emailController,
//             keyboardType: TextInputType.emailAddress,
//             decoration: InputDecoration(
//               hintText: "Email",
//               prefixIcon: Icon(Icons.email),
//               helperText: "Enter Value in this field"
//             ),
//             validator: (value) {
//               if(value==null || value.isEmpty){
//                 return "Enter Value in this field";
//               }
//               return null;
//             },
//           ),
  
//           SizedBox(height: 30,),
  
//           TextFormField(
//             controller: passwordController,
//             keyboardType: TextInputType.visiblePassword,
//             decoration: InputDecoration(
//               hintText: "Password",
//               prefixIcon: Icon(Icons.password),
//               helperText: "Enter Value in Password"
//             ),
//             validator: (value){
//               if(value==null || value.isEmpty){
//                return "Enter Value in this field";
//               }
//               return null;
//             },
//           )
//           ,
  
//           SizedBox(height: 50,),
//            Roundbutton(
//             title: "Sing Up",
//             loading: loading,
//             onTap: (){
//               print("Button Click");
//               if(_formkey.currentState!.validate()){
//               singupcode();


//               }else{
//                 print("invalid");
//               }
//             },
//           ),
//           const SizedBox(
//             height: 30,
//           )
//           ,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Already have a account"),
//               TextButton(onPressed: (){
//   Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
//               }, child: Text("Login"))
//             ],
//           )
//           ],
//         )
      
//       )
//     ],
  
//   ),
// ),
//     );
//   }
// }
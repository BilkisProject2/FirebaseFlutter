// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_application_1/auth/forgot_password.dart';
// import 'package:flutter_application_1/posts/post_screen.dart';
// import 'package:flutter_application_1/auth/login_with_phonenuber.dart';
// import 'package:flutter_application_1/auth/signup_screen.dart';
// import 'package:flutter_application_1/widgets/RoundButton.dart';

// class   LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<LoginScreen>{
//   bool loading = false;
//   final _formfield = GlobalKey<FormState>();// check email or password is emty or not
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   final _auth = FirebaseAuth.instance;

//   @override
//   void dispose() {
  
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//   }

// void login() {
//   setState(() {
//     loading = true;
//   });

//   print("Loading Started: $loading");

//   _auth
//       .signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       )
//       .then((value) {
//         print("Login Success");

//         setState(() {
//           loading = false;
//         });

//         print("Loading Ended: $loading");

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PostScreen(),
//           ),
//         );
//       })
//       .onError((error, stackTrace) {
//         print(error);

//         setState(() {
//           loading = false;
//         });

//         print("Loading Ended: $loading");
//       });
// }

//   @override
//   Widget build(BuildContext context) {
//     //willpopscope when we want to do back and exist app 
//     return WillPopScope(
//       onWillPop: () async {
//         SystemNavigator.pop();
//         return true;
//       },
//       child: Scaffold(
        
//         appBar: AppBar(
//           //use to remove default back button
//           automaticallyImplyLeading: false,
//           title: Text(
//       "Bilkis"
//           ),
        
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
                
//                 Form(
//                   key: _formfield,
//                   child: Column(
//                     children: [
//             TextFormField(
//               keyboardType: TextInputType.emailAddress,
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     hintText: "Email",
//                     helperText: "ENTER YOUR EMAIL THERE EX abc.123@gmail.com",
//                     prefixIcon: Icon(Icons.alternate_email)
//                   ),
//                   validator :(value){
//                   if(value==null || value.isEmpty){
//                     return "Enter email there";
//                   }
//                   return null;
//                 }
//                 ),
            
                
//                 SizedBox(height: 20,),
            
//                 TextFormField(
//                   keyboardType:TextInputType.visiblePassword
//             ,controller: passwordController,
//             obscureText: true,
//             decoration: InputDecoration(
//               hintText: "Password",
//               helperText: "ENTER YOUR PASSWORD THERE",
//               prefixIcon: Icon(Icons.password)
//             ),
//             validator: (value){
//               if(value==null|| value.isEmpty){
//                 return 'Password value empty';
//               }
//               return null;
//             },
//                 ),
//                     ],
//                   )),
                
//             SizedBox(height: 40,),
//             Roundbutton(
           
//               title: "Login",
//                  loading: loading,
//               onTap: (){
//                 print("Button Click");
//                 if(_formfield.currentState!.validate()){
//             login();
//                 }else{
//                   print("invalid");
//                 }
//               },
//             ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(onPressed: (){
//                               Navigator.push(context, MaterialPageRoute(
//                                 builder: (context)=> ForgotPassword()));
//                                 }, child: Text("Forgot password")),
//                 ),
//             const SizedBox(height: 10,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,

//               children: [
//               Text("Don't have account?"),
//               TextButton(onPressed: (){
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context)=> SignupScreen()));
//               }, child: Text("Sign Up"))
//             ],),
        
//           SizedBox(height: 30,),
//             InkWell(
//               onTap: (){
//                 Navigator.push(context, 
//                 MaterialPageRoute(builder: (context)=>
//                 LoginWithPhonenuber()));
//               },
//               child: Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                   border: Border.all(
//                     color: Colors.black45
//                   )
//                 ),
//                 child: Center(
//                   child: Text("Login With Phone Number"),
//                 ),
//               ),
//             )
            
//               ],
//             ),
          
//           ),
//         )),
        
//     );
  
//   }
// }
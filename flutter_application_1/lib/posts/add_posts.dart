// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/ui/Utils/utils.dart';
// import 'package:flutter_application_1/widgets/RoundButton.dart';

// class AddPosts extends StatefulWidget {
//   const AddPosts({super.key});

//   @override
//   State<AddPosts> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<AddPosts> {

// final postController = TextEditingController();
//   bool loading = false;
//   final databaseref = FirebaseDatabase.instance.ref("Post");
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("ADD POST"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             TextFormField(
//               maxLines: 5,
//               controller:postController ,
//               decoration: InputDecoration(
//                 hintText: "WHAT IS IN YOUR MIND ?...",
//                 border: OutlineInputBorder()
        
//               ),
//             ),
//             SizedBox(height: 30,),
//             Roundbutton(title: "ADD IN FIREBASE",loading: loading, 
//             onTap: (){
//               setState(() {
//                 loading=true;
//               });
//               String id = DateTime.now().millisecondsSinceEpoch.toString();
// databaseref.child(id).set({
//   'title': postController.text.toString(),
//   'id':id
// }).then((value){
// Utils().toastMessage("DATA ADD");
//         setState(() {
//                 loading=false;
//               });
// }).onError((error, stackTrace){
// Utils().toastMessage(error.toString());
//  setState(() {
//                 loading=false;
//               });
// });
//             })
//           ],
        
//         ),
//       ),
//     );
//   }



// }
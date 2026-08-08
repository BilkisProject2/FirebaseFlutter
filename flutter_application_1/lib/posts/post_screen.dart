// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/posts/add_posts.dart';
// import 'package:flutter_application_1/ui/Utils/utils.dart';
// import 'package:flutter_application_1/auth/login_screen.dart';

// class PostScreen extends StatefulWidget {
//   const PostScreen({super.key});

//   @override
//   State<PostScreen> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<PostScreen> {

//   final auth = FirebaseAuth.instance;
//   final ref = FirebaseDatabase.instance.ref("Post");
//   final ssearchfilter=TextEditingController();
// final editcontoller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: Text("POST"),
//         actions: [
//           IconButton(onPressed: (){
// auth.signOut().then((value){


//   Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
// }).onError((error, stackTrace) {
// Utils().toastMessage(error.toString());
// } 
// );
//           }, icon: Icon(Icons.logout),),
//           SizedBox(width: 10,)
//         ],
//       ),

//       body: Column(



//         children: [
// SizedBox(height: 10,),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               controller: ssearchfilter,
//               decoration: InputDecoration(
//                 hintText: "Search",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
//               ),
//                onChanged:(String value){
// setState(() {
  
//             });
//                }
           
//           ),
//           ),

       
//           Expanded(child: 
//            FirebaseAnimatedList(query: ref, 
//            defaultChild: Text("Loading"),
//        itemBuilder: (context,snapshot,animation,index){

// final title = snapshot.child('title').value.toString();

// if(ssearchfilter.text.isEmpty){
//  return ListTile(
//           title: Text(snapshot.child('title').value.toString()),
//           subtitle: Text(snapshot.child('id').value.toString()),
//           trailing: PopupMenuButton(
//             onSelected:(value){
//               if(value==1){
//                  showmydiloge(
//         title,
//         snapshot.child('id').value.toString(),
//       );
//               }else if(value==2){
//                 ref.child(snapshot.child('id').value.toString()).remove();
//               }
//             },
//             icon:Icon(Icons.more_vert),

//           itemBuilder:(context)=>[ 
//             PopupMenuItem(
//               value:1,
//               child: ListTile(
//         leading: Icon(Icons.edit),
//         title: Text("Edit"),
//       ),
//             ),
//             PopupMenuItem(
//               value:2,
//               child:ListTile(
//         leading: Icon(Icons.delete),
//         title: Text("Delete"),
//       ),
//             )
//         ])
//         );
// }else if(title.toLowerCase().contains(ssearchfilter.text.toLowerCase())){
// return ListTile(
//           title: Text(snapshot.child('title').value.toString()),
//           subtitle: Text(snapshot.child('id').value.toString()),
//         );

       
//        }else{
//   return Container();
//        }})
  
//           )
//         ],
//       ),

//       floatingActionButton: FloatingActionButton(onPressed: (){
// Navigator.push(context, MaterialPageRoute
// (builder: (context)=> AddPosts()));
//       },
//       child: Icon(Icons.add),),
//     );
//   }

// Future<void> showmydiloge(String title, String id) async{
//   editcontoller.text = title;
//   return showDialog(context:context,
//   builder:(BuildContext context){
//  return AlertDialog(
//   title:Text('Update'),
//   content:Container(
//     child:TextField(
//       controller:editcontoller,

//     ),
    
//   ),
//   actions:[
//       TextButton(onPressed:(){
//         Navigator.pop(context);
//         ref.child(id).update({
//           'title': editcontoller .text.toLowerCase()
//         }).then((value){
//           Utils().toastMessage( "Post Updated");
//         }).onError((error, stackTrace){
//           Utils().toastMessage(error.toString());
//         });
//       } , child:Text("Update")),

//       TextButton(onPressed:(){
//         Navigator.pop(context);
//       } , child:Text("Cancel")),
//     ]
//  );
//   });
// }


// }

//   //  Expanded(
//   //         child:StreamBuilder(stream: ref.onValue, 
//   //         builder:(context, AsyncSnapshot<DatabaseEvent>snapshot) {

//   //           if(!snapshot.hasData){
//   //             return Center(child: CircularProgressIndicator(),);
//   //           }else{
//   //             Map<dynamic,dynamic> map = snapshot.data!.snapshot.value as dynamic;
//   //             List<dynamic> list = [];
//   //             list.clear();
//   //             list = map.values.toList();
//   //  return ListView.builder(itemBuilder: (context,index){
//   //             return ListTile(
//   //               title: Text(list[index]['title'].toString()),
//   //               subtitle: Text(list[index]['id'].toString()),
//   //             );

//   //           });
//   //           }
         
//   //         })
//   //         ),
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Firestore/addpostfirestore.dart';
import 'package:flutter_application_1/auth/login_screen.dart';
import 'package:flutter_application_1/ui/Utils/utils.dart';

class FirestoreListScreen extends StatefulWidget {
  const FirestoreListScreen({super.key});

  @override
  State<FirestoreListScreen> createState() =>
   _MyWidgetState();
}

class _MyWidgetState extends 
State<FirestoreListScreen> {

  final auth = FirebaseAuth.instance;
final editcontoller = TextEditingController();
  final firestore= FirebaseFirestore.instance.collection("Post").snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection("Post");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("POST"),
        actions: [
          IconButton(onPressed: (){
auth.signOut().then((value){


  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
}).onError((error, stackTrace) {
Utils().toastMessage(error.toString());
} 
);
          }, icon: Icon(Icons.logout),),
          SizedBox(width: 10,)
        ],
      ),

      body: Column(



        children: [
       SizedBox(height: 20,),
       StreamBuilder<QuerySnapshot>
       (stream:firestore,
       builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

if(snapshot.connectionState == ConnectionState.waiting)
return CircularProgressIndicator();

if(snapshot.hasError)
return Text('SOME ERROE');


        return  Expanded(child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {

              return ListTile(
                onTap: () {
showmydiloge(snapshot.data!.docs[index]['title'].toString(),snapshot.data!.docs[index]['id'].toString() );
               
                  ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                          'title':"Bilkis"
                  }).then((value){
Utils().toastMessage("UPDATE SUCEESFULLY SCREEEN");
                  }).onError((error,stackTrace){
Utils().toastMessage(error.toString());
                  });


                  
                },

              

                onLongPress: () {
                  ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                },
                title: Text(snapshot.data!.docs[index]['title'].toString()),
                subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
              );
            },
           
  
          )
          );
       } ,),
         
        ]
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
Navigator.push(context, MaterialPageRoute
(builder: (context)=> Addpostfirestore()));
      },
      child: Icon(Icons.add),),
    );
  }

Future<void> showmydiloge(String title, String id) async{
  editcontoller.text = title;
  return showDialog(context:context,
  builder:(BuildContext context){
 return AlertDialog(
  title:Text('Update'),
  content:Container(
    child:TextField(
      controller:editcontoller,

    ),
    
  ),
  actions:[
      TextButton(onPressed:(){
        Navigator.pop(context);
       ref.doc(id).update({
        'title': editcontoller.text.toLowerCase()
       }).then((value){
Utils().toastMessage("Post Updated");
Navigator.pop(context);
       }).onError((error, stackTrace){
Utils().toastMessage(error.toString());
       });
  
      } , child:Text("Update")),

      TextButton(onPressed:(){
        Navigator.pop(context);
      } , child:Text("Cancel")),
    ]
 );
  });
}
}
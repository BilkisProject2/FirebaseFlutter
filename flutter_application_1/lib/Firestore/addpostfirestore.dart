import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/widgets/RoundButton.dart';

class Addpostfirestore extends StatefulWidget {
  const Addpostfirestore({super.key});

  @override
  State<Addpostfirestore> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Addpostfirestore> {

final postController = TextEditingController();
  bool loading = false;
  
  final firestore= FirebaseFirestore.instance.collection("Post");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD POST"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              maxLines: 5,
              controller:postController ,
              decoration: InputDecoration(
                hintText: "WHAT IS IN YOUR MIND ?...",
                border: OutlineInputBorder()
        
              ),
            ),
            SizedBox(height: 30,),
            Roundbutton(title: "ADD IN FIRESTORE",loading: loading, 
            onTap: (){
            setState(() {
                loading=true;
              });
String id = DateTime.now().millisecondsSinceEpoch.toString();
              firestore.doc(id).set({
         'title': postController.text.toString(),
         'id':id

              }).then((value){
                setState(() {
                  loading=false;
                });
Utils().toastMessage("Post Added");
              }).onError((error, stackTrace){
                setState(() {
                  loading=false;
                });
                Utils().toastMessage(error.toString());
              });
            })
          ],
        
        ),
      ),
    );
  }



}
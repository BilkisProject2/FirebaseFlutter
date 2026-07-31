import 'package:flutter/material.dart';
import 'package:flutter_application_1/Rivepod/provider/realtime_post_provider.dart';
import 'package:flutter_application_1/ui/Utils/utils.dart';
import 'package:flutter_application_1/widgets/RoundButton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({super.key});

  @override
  ConsumerState<AddPostScreen> createState() =>
      _AddPostScreenState();
}

class _AddPostScreenState
    extends ConsumerState<AddPostScreen> {

  final postController = TextEditingController();

  bool loading = false;

  Future<void> addPost() async {

    if (postController.text.trim().isEmpty) {

      Utils().toastMessage("Enter Post");

      return;
    }

    setState(() {
      loading = true;
    });

    try {

      await ref
          .read(realtimeRepositoryProvider)
          .addPost(postController.text);

      Utils().toastMessage("Post Added");

      Navigator.pop(context);

    } catch (e) {

      Utils().toastMessage(e.toString());

    }

    setState(() {
      loading = false;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("ADD POST"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(

              controller: postController,

              maxLines: 5,

              decoration: const InputDecoration(

                hintText: "WHAT IS IN YOUR MIND?",

                border: OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 30),

            Roundbutton(

              title: "ADD IN FIREBASE",

              loading: loading,

              onTap: addPost,

            )

          ],

        ),

      ),

    );

  }

}
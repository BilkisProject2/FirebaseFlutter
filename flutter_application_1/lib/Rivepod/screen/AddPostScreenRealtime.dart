import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/Utils/utils.dart';
import 'package:flutter_application_1/widgets/RoundButton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/post_provider.dart';


class AddPostScreenRealtime extends ConsumerStatefulWidget {
  const AddPostScreenRealtime({super.key});

  @override
  ConsumerState<AddPostScreenRealtime> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends ConsumerState<AddPostScreenRealtime> {
  final TextEditingController postController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  Future<void> addPost() async {
    if (postController.text.trim().isEmpty) {
      Utils().toastMessage("Please enter a post");
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await ref
          .read(postRepositoryProvider)
          .addPost(postController.text.trim());

      Utils().toastMessage("Post Added Successfully");

      postController.clear();

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
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextFormField(
              controller: postController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "WHAT'S IN YOUR MIND?",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            Roundbutton(
              title: "ADD IN FIRESTORE",
              loading: loading,
              onTap: addPost,
            ),
          ],
        ),
      ),
    );
  }
}
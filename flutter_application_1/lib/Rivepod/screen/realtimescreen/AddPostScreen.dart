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
        .addPost(postController.text.trim());

    if (!mounted) return;

    setState(() {
      loading = false;
    });

    Utils().toastMessage("Post Added");

    debugPrint("🔥 BEFORE POP");
    debugPrint("🔥 CAN POP = ${Navigator.canPop(context)}");

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    debugPrint("🔥 AFTER POP");
  } catch (e, stackTrace) {
    if (!mounted) return;

    setState(() {
      loading = false;
    });

    debugPrint("❌ ADD POST ERROR: $e");
    debugPrint("❌ STACK: $stackTrace");

    Utils().toastMessage(e.toString());
  }
}

  @override
  Widget build(BuildContext context) {
print("🔥🔥 ADD POST BUILD");
  print("🔥🔥 CAN POP IN ADD SCREEN = ${Navigator.of(context).canPop()}");

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
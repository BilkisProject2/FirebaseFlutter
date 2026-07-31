import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Rivepod/loginpart/screen/LoginScreen.dart';
import 'package:flutter_application_1/Rivepod/screen/realtimescreen/AddPostScreen.dart';
import 'package:flutter_application_1/ui/Utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/post_provider.dart';

class FirestoreListScreen extends ConsumerStatefulWidget {
  const FirestoreListScreen({super.key});

  @override
  ConsumerState<FirestoreListScreen> createState() =>
      _FirestoreListScreenState();
}

class _FirestoreListScreenState
    extends ConsumerState<FirestoreListScreen> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController editController =
      TextEditingController();

  @override
  void dispose() {
    editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final postAsync = ref.watch(postStreamProvider);

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("POST"),

        actions: [

          IconButton(

            onPressed: () async {

              await auth.signOut();

              if (mounted) {

                Navigator.pushReplacement(

                  context,

                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),

                );

              }

            },

            icon: const Icon(Icons.logout),

          )

        ],

      ),

      body: postAsync.when(

        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (error, stackTrace) {

          return Center(
            child: Text(error.toString()),
          );

        },

        data: (posts) {

          return ListView.builder(

            itemCount: posts.length,

            itemBuilder: (context, index) {

              final post = posts[index];

              return ListTile(

                title: Text(post.title),

                subtitle: Text(post.id),

                onTap: () {

                  showMyDialog(
                    post.title,
                    post.id,
                  );

                },

                onLongPress: () async {

                  await ref
                      .read(postRepositoryProvider)
                      .deletePost(post.id);

                  Utils().toastMessage("Post Deleted");

                },

              );

            },

          );

        },

      ),

      floatingActionButton: FloatingActionButton(

        child: const Icon(Icons.add),

        onPressed: () {

          Navigator.push(

            context,

            MaterialPageRoute(
              builder: (_) => const AddPostScreen(),
            ),

          );

        },

      ),

    );
  }

  Future<void> showMyDialog(
      String title,
      String id,
      ) async {

    editController.text = title;

    return showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text("Update"),

          content: TextField(

            controller: editController,

          ),

          actions: [

            TextButton(

              onPressed: () async {

                await ref
                    .read(postRepositoryProvider)
                    .updatePost(
                      id,
                      editController.text.trim(),
                    );

                Utils().toastMessage("Post Updated");

                if (mounted) {
                  Navigator.pop(context);
                }

              },

              child: const Text("Update"),

            ),

            TextButton(

              onPressed: () {

                Navigator.pop(context);

              },

              child: const Text("Cancel"),

            ),

          ],

        );

      },

    );

  }

}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Rivepod/Model/PostModel.dart';
import 'package:flutter_application_1/Rivepod/loginpart/screen/LoginScreen.dart';
import 'package:flutter_application_1/Rivepod/provider/realtime_post_provider.dart';
import 'package:flutter_application_1/Rivepod/screen/realtimescreen/AddPostScreen.dart';

import 'package:flutter_application_1/ui/Utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final searchController = TextEditingController();

  final editController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postAsync = ref.watch(realtimePostProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("POST"),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await auth.signOut();

                if (mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                }
              } catch (e) {
                Utils().toastMessage(e.toString());
              }
            },
            icon: const Icon(Icons.logout),
          ),
          const SizedBox(width: 10),
        ],
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

      body: Column(
        children: [

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: postAsync.when(
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },

              error: (error, stackTrace) {
                return Center(
                  child: Text(error.toString()),
                );
              },

              data: (posts) {

                final List<PostModel> filteredPosts =
                    posts.where((post) {

                  return post.title
                      .toLowerCase()
                      .contains(
                        searchController.text.toLowerCase(),
                      );

                }).toList();

                return ListView.builder(

                  itemCount: filteredPosts.length,

                  itemBuilder: (context, index) {

                    final post = filteredPosts[index];

                    return ListTile(

                      title: Text(post.title),

                      subtitle: Text(post.id),

                      trailing: PopupMenuButton(

                        onSelected: (value) {

                          if (value == 1) {

                            showMyDialog(
                              post.title,
                              post.id,
                            );

                          }

                          if (value == 2) {

                            ref
                                .read(
                                    realtimeRepositoryProvider)
                                .deletePost(post.id);

                            Utils().toastMessage(
                                "Post Deleted");

                          }

                        },

                        itemBuilder: (context) => [

                          const PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              leading: Icon(Icons.edit),
                              title: Text("Edit"),
                            ),
                          ),

                          const PopupMenuItem(
                            value: 2,
                            child: ListTile(
                              leading: Icon(Icons.delete),
                              title: Text("Delete"),
                            ),
                          ),

                        ],

                      ),

                    );

                  },

                );

              },

            ),
          ),

        ],
      ),
    );
  }
  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Post"),

          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              hintText: "Enter New Title",
              border: OutlineInputBorder(),
            ),
          ),

          actions: [

            TextButton(
              onPressed: () async {

                try {

                  await ref
                      .read(realtimeRepositoryProvider)
                      .updatePost(
                        id,
                        editController.text.trim(),
                      );

                  if (mounted) {
                    Navigator.pop(context);
                  }

                  Utils().toastMessage("Post Updated REALTIME DATABASE");

                } catch (e) {

                  Utils().toastMessage(e.toString());

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

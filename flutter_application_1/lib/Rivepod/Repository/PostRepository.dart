import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Rivepod/Model/PostModel.dart';

class PostRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference get postCollection =>
      firestore.collection("Post");

  Stream<List<PostModel>> getPosts() {
    return postCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((e) =>
              PostModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<void> addPost(String title) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    await postCollection.doc(id).set({
      "id": id,
      "title": title,
    });
  }

  Future<void> updatePost(String id, String title) async {
    await postCollection.doc(id).update({
      "title": title,
    });
  }

  Future<void> deletePost(String id) async {
    await postCollection.doc(id).delete();
  }
}
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/Rivepod/Model/PostModel.dart';


class RealtimePostRepository {
  final DatabaseReference database =
      FirebaseDatabase.instance.ref("Post");

  Stream<List<PostModel>> getPosts() {
    return database.onValue.map((event) {
      final data = event.snapshot.value;

      if (data == null) return [];

      final map = Map<dynamic, dynamic>.from(data as Map);

      return map.entries.map((e) {
        return PostModel.fromMap(
            Map<String, dynamic>.from(e.value));
      }).toList();
    });
  }

  Future<void> addPost(String title) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    await database.child(id).set({
      "id": id,
      "title": title,
    });
  }

  Future<void> updatePost(
      String id,
      String title,
      ) async {
    await database.child(id).update({
      "title": title,
    });
  }

  Future<void> deletePost(String id) async {
    await database.child(id).remove();
  }
}
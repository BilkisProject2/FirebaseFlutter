import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Rivepod/Model/PostModel.dart';


class RealtimePostRepository {
  final DatabaseReference database =
      FirebaseDatabase.instance.ref("Post");

Stream<List<PostModel>> getPosts() {
  /*
  database.onValue
return database.onValue.map((event) {

This is one of the most important Firebase lines.

database.onValue

means:

Listen for changes at the Post location.

Suppose Firebase has:

Post 1
Post 2

Then someone adds:

Post 3

onValue notices the change.

Firebase changed
       ↓
onValue
       ↓
event
10. event
(event)

Firebase gives you an event.

Think:

Firebase

"Something changed!"

        ↓

event

The event contains information about the current Firebase data.
  */
  return database.onValue.map((event) {

    debugPrint("🔥 FIREBASE EVENT RECEIVED");

    /*
    Get Firebase data
final data = event.snapshot.value;

This is VERY important.

Firebase gives you a snapshot.

event
 ↓
snapshot
 ↓
value

So:

event.snapshot.value

means:

Get the actual data stored in Firebase.

For example:

{
  "123": {
    "id": "123",
    "title": "Flutter"
  },
  "456": {
    "id": "456",
    "title": "Firebase"
  }
}

    */

    final data = event.snapshot.value;

    debugPrint("🔥 FIREBASE DATA: $data");

    if (data == null) {
      debugPrint("🔥 DATA IS NULL");
            /*
        15. Return empty list
return <PostModel>[];

If there are no posts, return an empty list.

Think:

No Firebase data

↓

[]


No posts.
        */
      return <PostModel>[];
    }

    try {

      /*
      18. Convert Firebase data to Map
final map = Map<dynamic, dynamic>.from(data as Map);

This is probably the most confusing line.

Let's take it slowly.

Firebase gives you something like:

data

{
  123: {
    id: 123,
    title: Flutter
  }
}

But we want to work with it as a Dart Map.

So:

data as Map

means:

Treat data as a Map.

Then:

Map<dynamic, dynamic>.from(...)

creates a Map from that data.

So:

Firebase data
      ↓
Map
      */

      final map = Map<dynamic, dynamic>.from(data as Map);

      debugPrint("🔥 MAP: $map");

      final posts = map.entries.map((e) {

        debugPrint("🔥 CURRENT ENTRY: ${e.value}");

  

        return PostModel.fromMap(
          Map<String, dynamic>.from(e.value),
        );

      }).toList();

      debugPrint("🔥 POSTS CREATED: ${posts.length}");

      return posts;

    } catch (e, stackTrace) {

      debugPrint("❌ ERROR IN getPosts: $e");
      debugPrint("❌ STACK TRACE: $stackTrace");

      rethrow;
    }
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
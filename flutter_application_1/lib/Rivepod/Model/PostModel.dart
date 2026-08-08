class PostModel {
  final String id;
  final String title;

  PostModel({
    required this.id,
    required this.title,
  });

  /*
  factory

A factory constructor is a special constructor that creates an object, often from existing data instead of manually entering 
every value


First, what problem are we solving?

Suppose Firebase sends this data:

{
  "id": "101",
  "title": "Learn Flutter"
}

Flutter receives it like this:

Map<String, dynamic> map

Think of a Map as a box with labels.

---------------------
| id    | 101       |
---------------------
| title | Learn...  |
---------------------

Now your app wants a PostModel object, not a Map.

So we must convert

Firebase Map
        ↓
PostModel Object

That's exactly what fromMap() does.

Line 1
factory PostModel.fromMap(Map<String, dynamic> map) {

Let's break it into small pieces.

Part 1
factory

Don't worry too much about this word for now.
Just remember:

"factory" means this function will create a PostModel object.

Think of it like a machine.

Map
 ↓
Machine
 ↓
PostModel

Part 2
PostModel

Which object are we creating?

Answer:

PostModel
Part 3
.fromMap

This is just the function's name.
you can write any name 

Part 4
(Map<String, dynamic> map)

This means:

The function needs one input.

That input is called

map

Example:

map

↓

{
"id":"101",
"title":"Flutter"
}

So now inside this function,

map

contains

id = 101

title = Flutter


What is ??

This scares everyone at first.

It is actually very easy.

??

means

If the left side is null, use the right side.

Imagine a real factory 🏭
Firebase gives

+----------------------+
| id    = 101          |
| title = Flutter      |
+----------------------+

            │
            ▼

     fromMap() Factory

            │
            ▼

+----------------------+
| PostModel            |
| id = 101             |
| title = Flutter      |
+----------------------+

One sentence to remember forever
fromMap() = Convert a Firebase Map into a Dart object.
toMap() = Convert a Dart object back into a Firebase Map.
  */

  factory PostModel.fromMap(Map<String, dynamic> maps) {
    return PostModel(
      id: maps['id'] ?? '',
      title: maps['title'] ?? '',
    );

  


  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
    };
  }
}
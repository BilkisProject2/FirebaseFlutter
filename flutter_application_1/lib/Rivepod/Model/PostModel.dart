class PostModel {
  final String id;
  final String title;

  PostModel({
    required this.id,
    required this.title,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
    };
  }
}
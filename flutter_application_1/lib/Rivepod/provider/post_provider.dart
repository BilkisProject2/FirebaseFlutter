import 'package:flutter_application_1/Rivepod/Model/PostModel.dart';
import 'package:flutter_application_1/Rivepod/Repository/PostRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository();
});

final postStreamProvider = StreamProvider<List<PostModel>>((ref) {
  return ref.watch(postRepositoryProvider).getPosts();
});
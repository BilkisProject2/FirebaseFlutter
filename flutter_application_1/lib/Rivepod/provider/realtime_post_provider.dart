import 'package:flutter_application_1/Rivepod/Model/PostModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/realtime_post_repository.dart';

final realtimeRepositoryProvider =
Provider<RealtimePostRepository>((ref) {

  return RealtimePostRepository();

});

final realtimePostProvider =
StreamProvider<List<PostModel>>((ref) {

  return ref
      .watch(realtimeRepositoryProvider)
      .getPosts();

});
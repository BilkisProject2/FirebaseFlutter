import 'package:flutter_application_1/Rivepod/loginpart/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final authRepositoryProvider =
Provider<AuthRepository>((ref) {

  return AuthRepository();

});
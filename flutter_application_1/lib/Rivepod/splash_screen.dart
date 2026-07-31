import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Rivepod/loginpart/Provider/authRepositoryProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Firestore/firestore_list_screen.dart';
import '../../auth/login_screen.dart';


class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() {

    final repo = ref.read(authRepositoryProvider);

    Timer(const Duration(seconds: 3), () {

      if (repo.getCurrentUser() != null) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const FirestoreListScreen(),
          ),
        );

      } else {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );

      }

    });

  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(

      body: Center(

        child: CircularProgressIndicator(),

      ),

    );

  }

}
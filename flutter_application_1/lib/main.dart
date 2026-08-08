import 'package:flutter/material.dart';
import 'package:flutter_application_1/Rivepod/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';


void main() async {
  print("🔥🔥🔥 MAIN STARTED 🔥🔥🔥");

  WidgetsFlutterBinding.ensureInitialized();

  print("🔥🔥🔥 BEFORE FIREBASE 🔥🔥🔥");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("🔥🔥🔥 FIREBASE INITIALIZED 🔥🔥🔥");

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
import 'package:firebase_core/firebase_core.dart';
import 'package:interfone_digital/utils/providers.dart';
import 'package:interfone_digital/views/widgets/auth_check.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupProviders();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 241, 241, 235),
              brightness: Brightness.dark),
          useMaterial3: true),
      home: const AuthCheck(),
    );
  }
}

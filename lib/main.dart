import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gestion_tickets/firebase_options.dart';
import 'package:gestion_tickets/login/connexion.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: connexion(),
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 11, 10, 11),
      ),
    );
  }
}




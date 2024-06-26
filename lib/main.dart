import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestion_tickets/control/control_page.dart';
import 'package:gestion_tickets/provider/EtudiantModel.dart';
import 'package:provider/provider.dart';
import 'package:gestion_tickets/firebase_options.dart';
import 'package:gestion_tickets/screens/home_page.dart';


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
    return ChangeNotifierProvider(
      create: (context) => EtudiantModel(), // Créez une instance de votre modèle de données pour l'utilisateur
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<EtudiantModel>(
          builder: (context, userModel, _) {
            // Utilisez Consumer pour écouter les changements dans le modèle de données de l'utilisateur
            // et afficher la page d'accueil si l'utilisateur est connecté, sinon affichez la page de connexion
            return userModel.etudiant != null ?   const MainScreen(): HomePage();
          },
        ),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}

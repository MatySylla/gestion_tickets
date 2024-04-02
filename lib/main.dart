import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestion_tickets/login/connexion.dart';
import 'package:gestion_tickets/login/provider/EtudiantModel.dart';
import 'package:gestion_tickets/screens/EtudiantHome.dart';
import 'package:provider/provider.dart';
import 'package:gestion_tickets/control/control_page.dart';
import 'package:gestion_tickets/firebase_options.dart';
import 'package:gestion_tickets/screens/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EtudiantModel(), // Créez une instance de votre modèle de données pour l'utilisateur
      child: MaterialApp(
        home: Consumer<EtudiantModel>(
          builder: (context, userModel, _) {
            // Utilisez Consumer pour écouter les changements dans le modèle de données de l'utilisateur
            // et afficher la page d'accueil si l'utilisateur est connecté, sinon affichez la page de connexion
            return userModel.etudiant != null ? const EtudiantHomePage() : Connexion();
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

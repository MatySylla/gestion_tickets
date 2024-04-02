import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_tickets/login/inscription.dart';
import 'package:gestion_tickets/login/provider/EtudiantModel.dart';
import 'package:gestion_tickets/main.dart';
import 'package:gestion_tickets/model/Etudiant.dart';
import 'package:gestion_tickets/screens/EtudiantHome.dart';
import 'package:provider/provider.dart'; // Importez la page d'inscription

// ignore: camel_case_types
class Connexion extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Connexion({Key? key});

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      // Authentification de l'utilisateur
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Récupérer les informations de l'utilisateur connecté
      User? user = userCredential.user;
      if (user != null) {
        // Mettre à jour les données de l'étudiant dans EtudiantModel
        // ignore: use_build_context_synchronously
        await Provider.of<EtudiantModel>(context, listen: false)
            .fetchEtudiantDataFromFirestore(user.uid);

        // Rediriger vers la page d'accueil de l'étudiant
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const EtudiantHomePage(),
        ));
      }
    } catch (e) {
      // En cas d'erreur d'authentification
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur d\'authentification : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [const SizedBox(height: 50),
          Image.asset(
            'assets/login.png'
          ),
          const Text("Bien venue",
          style: TextStyle(
            color: Color.fromARGB(255, 183, 179, 179),
            fontSize: 16
          ),

          ),
          const SizedBox(height: 25),
          TextField(
            controller: _emailController,
            style: const TextStyle(fontSize: 10),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),

          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _passwordController,
            style: const TextStyle(fontSize: 10),
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
            obscureText: true,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => _signInWithEmailAndPassword(context),
            child: const Text('Se connecter'),
          ),
          TextButton(
            onPressed: () {
              // Naviguer vers la page d'inscription
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              );
            },
            child: const Text('Créer un compte'),
          ),
        ],
      ),
    );
  }
}

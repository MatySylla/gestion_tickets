import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_tickets/login/inscription.dart';
import 'package:gestion_tickets/main.dart';
import 'package:gestion_tickets/model/Etudiant.dart';
import 'package:gestion_tickets/screens/EtudiantHome.dart'; // Importez la page d'inscription

// ignore: camel_case_types
class connexion extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  connexion({super.key});

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    // Récupérer les informations de l'utilisateur connecté
    User? user = userCredential.user;
    if (user != null) {
      // Récupérer les informations supplémentaires de l'utilisateur à partir de Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('etudiant').doc(user.uid).get();
      if (userSnapshot.exists) {
        // L'utilisateur existe dans la collection Firestore
        // Récupérer le nom et le prénom de l'utilisateur à partir du snapshot
        String nom = userSnapshot['nom'];
        String prenom = userSnapshot['prenom'];

        // Créer un objet Etudiant avec les informations récupérées
        Etudiant etudiantConnecte = Etudiant(
          id: user.uid,
          email: user.email ?? '',
          nom: nom,
          prenom: prenom,
        );

        // Rediriger vers la page d'accueil de l'étudiant avec les informations de l'étudiant
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => EtudiantHomePage(etudiant: etudiantConnecte),
        ));
      } else {
        // L'utilisateur n'existe pas dans la collection Firestore
        // Gérer ce cas selon les besoins de votre application
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Utilisateur introuvable dans la base de données')),
        );
      }
    }
  } catch (e) {
    // En cas d'échec de l'authentification, affichez un message d'erreur
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erreur d\'authentification : $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page d\'Accueil'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _signInWithEmailAndPassword(context),
              child: const Text('Se connecter'),
            ),
            const SizedBox(height: 16.0),
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
      ),
    );
  }
}
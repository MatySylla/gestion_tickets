import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_tickets/main.dart';
import 'package:gestion_tickets/model/Etudiant.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  SignUpPage({Key? key});

  Future<void> _signUpWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Récupérer l'ID de l'utilisateur nouvellement créé
      String userId = userCredential.user!.uid;

      // Enregistrer les informations supplémentaires dans la base de données
      await saveUserData(userId);

      // Une fois l'utilisateur inscrit, redirigez-le vers la page principale
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  MyApp()),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'inscription : $e')),
      );
    }
  }

  

  Future<void> saveUserData(String userId) async {
    // Récupérer le nom et le prénom saisis par l'utilisateur
    String nom = _firstNameController.text.trim();
    String prenom = _lastNameController.text.trim();
    String email = _emailController.text.trim();

    Etudiant nouvelEtudiant = Etudiant(
    id: userId, // Utiliser l'ID de l'utilisateur comme identifiant de l'étudiant
    email: email,
    nom: nom,
    prenom: prenom,
  );

    // Enregistrer les informations dans la base de données, par exemple Firestore
    // Ici, nous supposons que vous avez une collection "users" dans Firestore
    // où chaque document a l'ID de l'utilisateur comme ID du document
    // Vous pouvez personnaliser cela selon votre structure de base de données
    await FirebaseFirestore.instance.collection('etudiant').doc(userId).set(
    nouvelEtudiant.toJson(),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'Prénom'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            const SizedBox(height: 16.0),
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
              onPressed: () => _signUpWithEmailAndPassword(context),
              child: const Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}

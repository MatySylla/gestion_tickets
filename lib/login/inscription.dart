// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_tickets/compositions/messageErreur.dart';
import 'package:gestion_tickets/main.dart';
import 'package:gestion_tickets/model/Etudiant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  // ignore: use_key_in_widget_constructors
  SignUpPage({Key? key});

  Future<void> _signUpWithEmailAndPassword(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();

    // Vérifier si les champs sont vides
    if (email.isEmpty ||
        password.isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty) {
          showErrorDialog(context, 'Veuillez remplir tous les champs.'
      );
      return;
    }
    // Valider l'adresse e-mail
    if (!RegExp(r'^[a-zA-Z]+\.[a-zA-Z]+@univ-thies\.sn$').hasMatch(email)) {
      (context,'Veuillez saisir votre adresse e-mail universitaire au format "@univ-thies.sn".'
      );
      return;
    }
    if (!RegExp(r'^\d{11}$').hasMatch(password)) {
      showErrorDialog(context,
          'Veuillez saisir une adresse e-mail au format "prenom.nom@univ-thies.sn".');

      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Récupérer l'ID de l'utilisateur nouvellement créé
      String userId = userCredential.user!.uid;

      // Enregistrer les informations supplémentaires dans la base de données
      await saveUserData(userId);

      // Une fois l'utilisateur inscrit, redirigez-le vers la page principale
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    } catch (e) {
      showErrorDialog(context, 'Erreur lors de l\'inscription : $e');
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/login.png'),
                TextField(
                  controller: _firstNameController,
                  style: const TextStyle(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Prenom',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _lastNameController,
                  style: const TextStyle(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _emailController,
                  style: const TextStyle(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  style: const TextStyle(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
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
        ));
  }
}

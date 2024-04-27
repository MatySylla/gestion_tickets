import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_tickets/compositions/messageErreur.dart';
import 'package:gestion_tickets/main.dart';
import 'package:gestion_tickets/model/Etudiant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  // ignore: use_key_in_widget_constructors
  SignUpPage({Key? key});

  Future<void> _signUpWithEmailAndPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String firstName = _firstNameController.text.trim();
      String lastName = _lastNameController.text.trim();

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Récupérer l'ID de l'utilisateur nouvellement créé
        String userId = userCredential.user!.uid;

        // Enregistrer les informations supplémentaires dans la base de données
        await saveUserData(userId, email, firstName, lastName);

        // Une fois l'utilisateur inscrit, redirigez-le vers la page principale
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MyApp()),
        );
      } catch (e) {
        showErrorDialog(context, 'Erreur lors de l\'inscription : $e');
      }
    }
  }

  Future<void> saveUserData(
      String userId, String email, String firstName, String lastName) async {
    Etudiant nouvelEtudiant = Etudiant(
      id: userId, // Utiliser l'ID de l'utilisateur comme identifiant de l'étudiant
      email: email,
      nom: lastName,
      prenom: firstName,
    );

    // Enregistrer les informations dans la base de données, par exemple Firestore
  
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/login.png'),
                TextFormField(
                  controller: _firstNameController,
                  style: const TextStyle(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Prénom',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre prénom';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre nom';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
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
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(
                            r'^[a-zA-Z]+\.[a-zA-Z0-9]+@univ-thies\.sn$')
                            .hasMatch(value)) {
                      return 'Veuillez saisir votre adresse e-mail universitaire au format "prenom.nom@univ-thies.sn"';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre mot de passe';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  style: const TextStyle(fontSize: 15),
                  decoration: const InputDecoration(
                    labelText: 'Confirmer le mot de passe',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez confirmer votre mot de passe';
                    }
                    if (value != _passwordController.text) {
                      return 'Les mots de passe ne correspondent pas';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => _signUpWithEmailAndPassword(context),
                  child: const Text('S\'inscrire'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

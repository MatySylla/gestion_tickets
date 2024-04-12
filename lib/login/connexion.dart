import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_tickets/compositions/messageErreur.dart';
import 'package:gestion_tickets/control/control_page.dart';
import 'package:gestion_tickets/login/ResetPasswordPage.dart';
import 'package:gestion_tickets/login/inscription.dart';
import 'package:gestion_tickets/provider/EtudiantModel.dart';
import 'package:provider/provider.dart'; // Importez la page d'inscription

class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);
   @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureTextPswd = true; // Ajout de _obscureTextPswd pour le contrôle de visibilité du mot de passe

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty || !RegExp(r"^[a-zA-Z0-9]+\.[a-zA-Z0-9]+@univ-thies\.sn$").hasMatch(value)) {
      return 'Entrez un e-mail valide.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un mot de passe';
    }
    
    if (value.length != 11 ||  !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Le mot de passe doit contenir exactement 11 chiffres';
    }
    return null;
  }

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
      if (user != null && _formKey.currentState!.validate()) {
        // Mettre à jour les données de l'étudiant dans EtudiantModel
        await Provider.of<EtudiantModel>(context, listen: false)
            .fetchEtudiantDataFromFirestore(user.uid);

        // Rediriger vers la page d'accueil de l'étudiant
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>  const MainScreen(),
        ));
      }
    } catch (e) {
      // En cas d'erreur d'authentification
      showErrorDialog(context, 'Erreur d\'authentification : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Image.asset('assets/login.png'),
            const Text(
              "Bienvenue",
              style: TextStyle(
                color: Color.fromARGB(255, 183, 179, 179),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
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
              validator: _validateEmail,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                       _obscureTextPswd = !_obscureTextPswd;
                    });
                  },
                  child: Icon(
                    _obscureTextPswd ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
              obscureText: _obscureTextPswd,
              validator: _validatePassword,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                  TextButton(
                    onPressed: () {
                      // Naviguer vers la page de réinitialisation de mot de passe
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                      );
                    },
                    child: const Text('Mot de passe oublié ?'),
                  ),
               ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()){
                  _signInWithEmailAndPassword(context);
                }
              },
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
      ),
    );
  }
}

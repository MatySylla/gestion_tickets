import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_tickets/compositions/messageErreur.dart';

class ResetPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  ResetPasswordPage({Key? key}) : super(key: key);

  Future<void> _resetPassword(BuildContext context) async {
    String email = _emailController.text.trim();

    // Vérifier si l'e-mail est valide
    if (!RegExp(r'^[a-zA-Z0-9]+\.[a-zA-Z0-9]+@univ-thies\.sn$').hasMatch(email)) {
      showErrorDialog(context, 'Veuillez saisir votre adresse e-mail universitaire au format "@univ-thies.sn".');
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Afficher un dialogue ou une boîte de dialogue pour informer l'utilisateur que le lien de réinitialisation a été envoyé
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Email de réinitialisation envoyé'),
          content: const Text('Un lien de réinitialisation de mot de passe a été envoyé à votre adresse e-mail. Veuillez vérifier votre boîte de réception.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      showErrorDialog(context, 'Erreur lors de l\'envoi du lien de réinitialisation : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réinitialiser le mot de passe'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ElevatedButton(
              onPressed: () => _resetPassword(context),
              child: const Text('Réinitialiser le mot de passe'),
            ),
          ],
        ),
      ),
    );
  }
}

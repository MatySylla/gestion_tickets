import 'package:flutter/material.dart';
import 'package:gestion_tickets/provider/EtudiantModel.dart';
import 'package:provider/provider.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 222, 243),
        title: const Text('Accueil',
          style: TextStyle(color: Colors.deepPurple, // Couleur du texte blanc
           ),
       ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer<EtudiantModel>(
        builder: (context, etudiantModel, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                color: Colors.white,
                child: etudiantModel.etudiant != null
                    ? Text(
                        'Bienvenue ${etudiantModel.etudiant!.prenom} ${etudiantModel.etudiant!.nom} !',
                        style: const TextStyle(
                          fontSize: 24.0,
                          color: Colors.deepPurple,
                        ),
                      )
                    : const Text(
                        'Chargement...',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.deepPurple,
                        ),
                      ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Action à effectuer lors de l'appui sur le bouton "Réserver un ticket"
                },
                child: const Text('Réserver un ticket'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Action à effectuer lors de l'appui sur le bouton "Acheter des tickets"
                },
                child: Text('Acheter des tickets'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Action à effectuer lors de l'appui sur le bouton "Consulter le solde"
                },
                child: Text('Consulter le solde'),
              ),
              // Autres fonctionnalités ou sections de la page d'accueil
            ],
          );
        },
      ),
    );
  }
}

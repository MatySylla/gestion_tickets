import 'package:flutter/material.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        backgroundColor: Colors.transparent, // Définit la barre d'application transparente
        elevation: 0, // Supprime l'ombre de la barre d'application
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey[300], // Couleur de fond grise
                borderRadius: BorderRadius.circular(20.0), // Coins arrondis
              ),
              child: const Text(
                'Bienvenue dans notre application',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20.0), // Espace entre le titre et les cartes
            _buildCard('assets/e-tick.jpeg', 'Description de l\'annonce 1'),
            _buildCard('assets/e-tick.jpeg', 'Description de l\'annonce 2'),
            SizedBox(height: 20.0), // Espace entre les annonces et les mises à jour
            _buildCard('assets/e-tick.jpeg', 'Description de la mise à jour 1'),
            _buildCard('assets/e-tick.jpeg', 'Description de la mise à jour 2'),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String  imagePath, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        elevation: 3, // Ajoute une ombre légère
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), // Coins arrondis
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover, // Ajuste l'image pour remplir le widget
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(15.0),
              title: Text(
                imagePath.contains('annonce') ? 'Annonce' : 'Mise à jour',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(subtitle),
            ),
          ],
        ),
      ),
    );
  }
}
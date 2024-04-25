import 'package:flutter/material.dart';
import 'package:gestion_tickets/portier/Historique.dart';
import 'package:gestion_tickets/portier/listeEtudiant.dart';
import 'package:gestion_tickets/portier/listeReservation.dart';

class AccueilPersonnel extends StatefulWidget {
  const AccueilPersonnel({Key? key}) : super(key: key);

  @override
  _AccueilPersonnelState createState() => _AccueilPersonnelState();
}

class _AccueilPersonnelState extends State<AccueilPersonnel> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil Personnel'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAccueilTab(),
          const HistoriqueAchats(), // Utilisation de la classe Historique pour afficher l'onglet "Historique"
          const ListeReservations(),
          const ListeEtudiants(),
        ],
              ),
      bottomNavigationBar: Material(
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: 'Accueil'),
            Tab(icon: Icon(Icons.history), text: 'Historique'),
            Tab(icon: Icon(Icons.list), text: 'Reservations'),
            Tab(icon: Icon(Icons.group), text: 'Liste_etudiants'),
          ],
        ),
      ),
    );
  }

  Widget _buildAccueilTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            color: Colors.white,
            child: const Text(
              'Bienvenue !',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.deepPurple,
              ),
            ),
          ),
          SizedBox(height: 20),

          Image.asset(
          'assets/welcome_image.png', // Remplacez le chemin par le chemin de votre image locale
          height: 200, // Ajustez la hauteur selon vos besoins
          width: double.infinity, // Ajustez la largeur pour occuper toute la largeur de l'écran
          fit: BoxFit.cover, // Ajustez le mode de remplissage selon vos besoins
        ),
        SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildFeatureCard(context, 'Nofication')),
              SizedBox(width: 10),
              Expanded(child: _buildFeatureCard(context, "Historique")),
            ],
          ),
          SizedBox(height: 10),
          // Autres fonctionnalités ou sections de la page d'accueil
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          // Action à effectuer lorsque la carte est appuyée
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildValidationTab() {
    // Contenu de l'onglet Validation
    return Center(
      child: Text('Validation'),
    );
  }
}


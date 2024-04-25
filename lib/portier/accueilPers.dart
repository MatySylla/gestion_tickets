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
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: const Text('E-CROUS'),
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
  return Stack(
    alignment: Alignment.topLeft, // Alignement au coin supérieur gauche
    children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/AP.jpg'),
            fit: BoxFit.fill,
          ),
        ),
      ),
      SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 170, vertical: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildFeatureCard(Icons.history, 'Historique', () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ListeEtudiants(),
                   ));}),
            SizedBox(height: 10),
            _buildFeatureCard(Icons.list, 'Réservations', () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ListeReservations(),
                   ));}),
            SizedBox(height: 10),
            _buildFeatureCard(Icons.group, 'Etudiants', () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ListeEtudiants(),
                   ));
            }),
            // Autres fonctionnalités ou sections de la page d'accueil
          ],
        ),
      ),
    ],
  );
}


  Widget _buildFeatureCard(IconData icon, String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(icon, size: 24),
                SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

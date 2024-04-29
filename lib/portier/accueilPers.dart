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
        title: const Text('E-CROUS - Personnel'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bienvenue dans l\'espace de travail!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Qu\'est-ce que vous voulez faire aujourd\'hui ?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  _buildMenuItem(
                    title: 'Historique',
                    subtitle: 'Consultez votre historique',
                    icon: Icons.history,
                    color: Colors.blueAccent,
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HistoriqueAchats(),
                      ));
                    },
                  ),
                  _buildMenuItem(
                    title: 'Réservations',
                    subtitle: 'Consultez vos réservations',
                    icon: Icons.list,
                    color: Colors.greenAccent,
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ListeReservations(),
                      ));
                    },
                  ),
                  _buildMenuItem(
                    title: 'Liste des Étudiants',
                    subtitle: 'Consultez la liste des étudiants',
                    icon: Icons.group,
                    color: Colors.orangeAccent,
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ListeEtudiants(),
                      ));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Ajout d'un card principal pour les annonces
            _buildAnimatedAnnouncementsCard([
              'Préparez-vous ! Demain c\'est l\'annonce du menu de demain !',
              'Nouveauté : Menu spécial pour le week-end !',
              'Annonce importante : Rappel des horaires de fermeture !',
            ]),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        color: Colors.deepPurple,
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home,color: Colors.white), text: 'Accueil'),
            Tab(icon: Icon(Icons.history,color: Colors.white), text: 'Historique'),
            Tab(icon: Icon(Icons.list,color: Colors.white), text: 'Réservations'),
            Tab(icon: Icon(Icons.group,color: Colors.white), text: 'Étudiants'),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color.withOpacity(0.7),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedAnnouncementsCard(List<String> announcements) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Annonces',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  return _buildAnnouncement(announcements[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncement(String announcement) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: AnimatedContainer(
        duration: const Duration(seconds: 5),
        curve: Curves.easeInOut,
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              announcement,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

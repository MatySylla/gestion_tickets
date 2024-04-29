import 'package:flutter/material.dart' hide VoidCallback; // Ajouter hide VoidCallback pour exclure de l'importation standard
import 'dart:ui' show VoidCallback; // Importez explicitement VoidCallback depuis dart:ui

import 'package:flutter/material.dart';
import 'package:gestion_tickets/provider/EtudiantModel.dart';
import 'package:gestion_tickets/widgets/historique/transaction.dart';
import 'package:gestion_tickets/widgets/menu/menu.dart';
import 'package:gestion_tickets/widgets/solde/achat.dart';
import 'package:gestion_tickets/widgets/solde/pageSolde.dart';
import 'package:provider/provider.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue !'),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<EtudiantModel>(
                    builder: (context, etudiantModel, child) {
                      final etudiant = etudiantModel.etudiant;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bonjour, ${etudiant?.prenom} ${etudiant?.nom}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Qu\'est-ce que vous voulez manger aujourd\'hui ?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      );
                    },
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
                    title: 'Menu du jour',
                    subtitle: 'Découvrez les plats proposés aujourd\'hui',
                    icon: Icons.restaurant_menu,
                    color: Colors.orangeAccent,
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const MenuView(),
                      ));
                    },
                  ),
                  _buildMenuItem(
                    title: 'Acheter des tickets',
                    subtitle: 'Achetez des tickets pour les repas',
                    icon: Icons.shopping_cart,
                    color: Colors.greenAccent,
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const PageAchatTickets(),
                      ));
                    },
                  ),
                  _buildMenuItem(
                    title: 'Solde des tickets',
                    subtitle: 'Consultez votre solde de tickets',
                    icon: Icons.monetization_on,
                    color: Colors.purpleAccent,
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => PageSoldeTickets(),
                      ));
                    },
                  ),
                  _buildMenuItem(
                    title: 'Historique des transactions',
                    subtitle: 'Consultez vos transactions précédentes',
                    icon: Icons.history,
                    color: Colors.blueAccent,
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HistoriqueTransactionsPage(),
                      ));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Ajout d'un card principal pour les annonces
            _buildAnimatedAnnouncementsCard([
              'Préparez-vous ! Demain c\'est l\'annonce du menu de demain !mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm',
              'Nouveauté : Menu spécial pour le week-end !mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm',
              'Annonce importante : Rappel des horaires de fermeture !mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm',
            ]),
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
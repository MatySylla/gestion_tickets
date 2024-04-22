import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_tickets/provider/EtudiantModel.dart';
import 'package:provider/provider.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDailyMenu(context, 'Menu du jour', 'Description du menu', 'assets/rizPoisson.jpg', context),
          SizedBox(height: 20), // Espacement entre les sections
          _buildWeeklyMenu(context),
        ],
      ),
    );
  }

  Widget _buildDailyMenu(BuildContext context, String title, String subtitle, String imagePath, BuildContext parentContext) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 200, // Hauteur de l'image
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _showReservationDialog(parentContext);
                  },
                  child: Text('Réserver'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String dayOfWeek, String title1, String subtitle1, String imagePath1, String title2, String subtitle2, String imagePath2, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            dayOfWeek,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMenuCard(title1, subtitle1, imagePath1, screenWidth / 2 - 20, context),
              _buildMenuCard(title2, subtitle2, imagePath2, screenWidth / 2 - 20, context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuCard(String title, String subtitle, String imagePath, double cardWidth, BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: SizedBox(
        width: cardWidth / 2 - 20,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 100,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.shopping_cart),
                  // Ajoutez d'autres icônes ou éléments ici selon vos besoins
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyMenu(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildWeeklyMenuTitle(),
          Divider(), // Ligne de séparation entre le titre et les menus
          _buildMenuItem(context, 'Lundi', 'Dèjeuner', 'Description du menu', 'assets/maafe.jpg', 'Diner', 'Description du menu', 'assets/rizYapp.jpg', screenWidth),
          Divider(), // Ligne de séparation entre les menus
          _buildMenuItem(context, 'Mardi', 'Dèjeuner', 'Description du menu', 'assets/rizYapp.jpg', 'Diner', 'Description du menu', 'assets/mbaxal.jpg', screenWidth),
          Divider(), // Ligne de séparation entre les menus
          _buildMenuItem(context, 'Mercredi', 'Dèjeuner', 'Description du menu', 'assets/rizYapp.jpg', 'Diner', 'Description du menu', 'assets/mbaxal.jpg', screenWidth),
          Divider(),
          _buildMenuItem(context, 'Jeudi', 'Dèjeuner', 'Description du menu', 'assets/rizYapp.jpg', 'Diner', 'Description du menu', 'assets/mbaxal.jpg', screenWidth),
          Divider(),
          _buildMenuItem(context, 'Vendredi', 'Dèjeuner', 'Description du menu', 'assets/rizYapp.jpg', 'Diner', 'Description du menu', 'assets/mbaxal.jpg', screenWidth),
          Divider(),
          _buildMenuItem(context, 'Samedi', 'Dèjeuner', 'Description du menu', 'assets/rizYapp.jpg', 'Diner', 'Description du menu', 'assets/mbaxal.jpg', screenWidth),
          Divider(),
          _buildMenuItem(context, 'Dimanche', 'Dèjeuner', 'Description du menu', 'assets/rizYapp.jpg', 'Diner', 'Description du menu', 'assets/mbaxal.jpg', screenWidth),
          Divider(),
          // Ajoutez les menus pour les autres jours de la semaine ici...
        ],
      ),
    );
  }

  Widget _buildWeeklyMenuTitle() {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        'Menus de la semaine',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

 void _showReservationDialog(BuildContext context) {
  int quantity = 1; // Initial quantity

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Réserver un repas'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Combien de repas voulez-vous réserver ?'),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                    ),
                    Text('$quantity'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Annuler'),
              ),
              TextButton(
                onPressed: () async {
                  // Débiter le nombre de repas réservés du solde de tickets repas de l'utilisateur
                  await Provider.of<EtudiantModel>(context, listen: false)
                      .debiterTickets(
                    idEtudiant: FirebaseAuth.instance.currentUser!.uid,
                    nombreTicketsRepas: quantity,
                    nombreTicketsPetitDej: 0, // Nombre de petit déjeuner, à ajuster si nécessaire
                  );

                  // Mettre à jour le solde des tickets repas dans PageSoldeTickets
                  await Provider.of<EtudiantModel>(context, listen: false)
                      .fetchSoldeTicketsRepasFromFirestore(FirebaseAuth.instance.currentUser!.uid);

                  // Afficher un message de confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Repas réservé avec succès'),
                    ),
                  );

                  // Mettre à jour le solde des tickets repas dans PageSoldeTickets
                  Provider.of<EtudiantModel>(context, listen: false)
                      .fetchSoldeTicketsRepasFromFirestore(FirebaseAuth.instance.currentUser!.uid);

                  Navigator.of(context).pop();
                },

                child: Text('Réserver'),
              ),
            ],
          );
        },
      );
    },
  );
}
}

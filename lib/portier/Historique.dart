import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_tickets/portier/accueilPers.dart';

class HistoriqueAchats extends StatelessWidget {
  const HistoriqueAchats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique des Achats'),

        leading: IconButton(
        onPressed: () {

           Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const AccueilPersonnel(),
          ));

          },
        icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
      ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tickets').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement des données'));
          } else {
            final transactions = snapshot.data!.docs;
            if (transactions.isEmpty) {
              return Center(child: Text('Aucune transaction trouvée.'));
            }
            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final userId = transaction['user_id'];
                final nombreTicketsRepas = transaction['nombreTicketsRepas'];
                final nombreTicketsPetitDej = transaction['nombreTicketsPetitDej'];
                final prixTotal = transaction['prix_total'];
                final timestamp = transaction['timestamp'];

                // Récupérer les informations de l'utilisateur à partir de son identifiant
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('etudiant').doc(userId).get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox.shrink(); // Ne rien afficher en attendant la récupération des données de l'utilisateur
                    } else if (userSnapshot.hasError || !userSnapshot.hasData) {
                      return SizedBox.shrink(); // Ne rien afficher en cas d'erreur ou si aucune donnée n'est trouvée pour l'utilisateur
                    } else {
                      final userData = userSnapshot.data!;
                      final nom = userData['nom'];
                      final prenom = userData['prenom'];

                      return Card(
                        child: ListTile(
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(' $prenom $nom'), // Afficher le nom et le prénom de l'utilisateur
                              
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tickets Petit Déj: $nombreTicketsPetitDej'),
                              Text('Tickets Repas: $nombreTicketsRepas'),
                              Text('$prixTotal FCFA'),
                              Text('Date: ${timestamp.toDate()}'),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_tickets/portier/accueilPers.dart';

class ListeReservations extends StatelessWidget {
  const ListeReservations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Récupérer la date de début de la journée en cours
    DateTime debutJournee = DateTime.now();
    debutJournee = DateTime(debutJournee.year, debutJournee.month, debutJournee.day);

    // Récupérer la date de fin de la journée en cours (ajoutez 1 jour et soustrayez 1 seconde)
    DateTime finJournee = debutJournee.add(Duration(days: 1)).subtract(Duration(seconds: 1));

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Réservations journalière'),
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
        stream: FirebaseFirestore.instance
            .collection('reservations')
            .where('date_reservation', isGreaterThanOrEqualTo: debutJournee)
            .where('date_reservation', isLessThanOrEqualTo: finJournee)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement des données'));
          } else {
            final reservations = snapshot.data!.docs;
            if (reservations.isEmpty) {
              return Center(child: Text('Aucune réservation trouvée pour aujourd\'hui.'));
            }
            return ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  final reservation = reservations[index];
                  final dateReservation = reservation['date_reservation'];
                  final nombrePlats = reservation['nombre_plats'];
                  final typeRepas = reservation['type_repas'];
                  final userId = reservation['user_id'];

                  return FutureBuilder(
                    future: Future.wait([
                      FirebaseFirestore.instance.collection('etudiant').doc(userId).get(),
                      FirebaseFirestore.instance.collection('etudiant').doc(userId).get(),
                    ]),
                    builder: (context, AsyncSnapshot<List<DocumentSnapshot>> userSnapshots) {
                      if (userSnapshots.connectionState == ConnectionState.waiting) {
                        return SizedBox.shrink();
                      } else if (userSnapshots.hasError) {
                        return SizedBox.shrink();
                      } else {
                        final userData = userSnapshots.data![0].data() as Map<String, dynamic>;
                        final nom = userData['nom'];
                        final prenom = userData['prenom'];
                        final userDataReserver = userSnapshots.data![1].data() as Map<String, dynamic>;
                        final nomReserver = userDataReserver['nom'];
                        final prenomReserver = userDataReserver['prenom'];

                        return Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Utilisateur: $prenom $nom'),
                                Text('Réservé par: $prenomReserver $nomReserver'),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date de réservation: ${dateReservation.toDate()}'),
                                Text('Nombre de plats: $nombrePlats'),
                                Text('Type de repas: $typeRepas'),
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

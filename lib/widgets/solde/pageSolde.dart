import 'package:flutter/material.dart';
import 'package:gestion_tickets/provider/EtudiantModel.dart';
import 'package:provider/provider.dart';

class PageSoldeTickets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solde des Tickets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<EtudiantModel>(
          builder: (context, etudiantModel, _) {
            if (etudiantModel.etudiant != null) {
              // Récupérer les tickets repas et petit déjeuner de l'étudiant depuis le modèle
              Future<int?> nombreTicketsRepas = etudiantModel.fetchSoldeTicketsRepasFromFirestore(etudiantModel.etudiant!.id);
              Future<int?> nombreTicketsPetitDej = etudiantModel.fetchSoldeTicketsPetitDejFromFirestore(etudiantModel.etudiant!.id);

              return FutureBuilder<int?>(
                future: nombreTicketsRepas,
                builder: (context, snapshotRepas) {
                  return FutureBuilder<int?>(
                    future: nombreTicketsPetitDej,
                    builder: (context, snapshotPetitDej) {
                      if (snapshotRepas.connectionState == ConnectionState.waiting ||
                          snapshotPetitDej.connectionState == ConnectionState.waiting) {
                        // Afficher un indicateur de chargement si les données sont en cours de chargement
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshotRepas.hasError || snapshotPetitDej.hasError) {
                        // Afficher un message d'erreur si une erreur s'est produite lors de la récupération des données
                        return Center(child: Text('Erreur de chargement des données'));
                      } else {
                        // Calculer le solde total des tickets
                        int soldeTotalTickets = (snapshotRepas.data ?? 0) + (snapshotPetitDej.data ?? 0);

                        // Afficher le solde des tickets dans l'interface utilisateur
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Solde des Tickets',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Tickets Repas: ${snapshotRepas.data ?? 0}',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Tickets Petit Déj: ${snapshotPetitDej.data ?? 0}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Solde Total: $soldeTotalTickets',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      }
                    },
                  );
                },
              );
            } else {
              // Si l'étudiant n'est pas disponible, affichez un message d'attente
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informations Personnelles:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  _buildPersonalInfo('Nom:', etudiantModel.etudiant!.prenom),
                  _buildPersonalInfo('Prénom:', etudiantModel.etudiant!.nom),
                  _buildPersonalInfo('Email:', etudiantModel.etudiant!.email),
                  SizedBox(height: 20),
                  Text(
                    'Solde des Tickets',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  FutureBuilder<num?>(
                    future: etudiantModel.fetchSoldeTicketsRepasFromFirestore(etudiantModel.etudiant!.id),
                    builder: (context, snapshotRepas) {
                      return FutureBuilder<num?>(
                        future: etudiantModel.fetchSoldeTicketsPetitDejFromFirestore(etudiantModel.etudiant!.id),
                        builder: (context, snapshotPetitDej) {
                          if (snapshotRepas.connectionState == ConnectionState.waiting ||
                              snapshotPetitDej.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshotRepas.hasError || snapshotPetitDej.hasError) {
                            return Center(child: Text('Erreur de chargement des données'));
                          } else {
                            num soldeTotalTickets = (snapshotRepas.data ?? 0) + (snapshotPetitDej.data ?? 0);

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildTicketItem('Tickets Repas', snapshotRepas.data ?? 0, Colors.blue),
                                    _buildTicketItem('Tickets Petit Déj', snapshotPetitDej.data ?? 0, Colors.green),
                                  ],
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
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _buildPersonalInfo(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 5),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildTicketItem(String title, num amount, Color color) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
          ),
          SizedBox(height: 5),
          Text(
            '$amount',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

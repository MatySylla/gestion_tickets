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
                  SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tickets Repas',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          _buildTicketInfo(
                            future: etudiantModel.fetchSoldeTicketsRepasFromFirestore(etudiantModel.etudiant!.id),
                            icon: Icons.fastfood,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tickets Petit Déj',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          _buildTicketInfo(
                            future: etudiantModel.fetchSoldeTicketsPetitDejFromFirestore(etudiantModel.etudiant!.id),
                            icon: Icons.free_breakfast,
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ),
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

  Widget _buildTicketInfo({required Future<num?> future, required IconData icon, required Color color}) {
    return FutureBuilder<num?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur de chargement des données'));
        } else {
          return Row(
            children: [
              Icon(icon, color: color),
              SizedBox(width: 10),
              Text(
                '${snapshot.data ?? 0}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          );
        }
      },
    );
  }
}
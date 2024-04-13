import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoriqueTransactionsPage extends StatefulWidget {
  const HistoriqueTransactionsPage({Key? key}) : super(key: key);

  @override
  _HistoriqueTransactionsPageState createState() => _HistoriqueTransactionsPageState();
}

class _HistoriqueTransactionsPageState extends State<HistoriqueTransactionsPage> {
  late String _userId;

  @override
  void initState() {
    super.initState();
    _userId = FirebaseAuth.instance.currentUser!.uid; // Obtenez l'ID de l'utilisateur connecté
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique des Transactions'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tickets')
            .where('user_id', isEqualTo: _userId) // Filtrer les transactions par ID utilisateur
            .snapshots(),
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

                // Construisez l'interface utilisateur pour afficher les détails de chaque transaction
                return ListTile(
                  title: Text('Utilisateur: $userId'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tickets Repas: $nombreTicketsRepas'),
                      Text('Tickets Petit Déj: $nombreTicketsPetitDej'),
                      Text('Prix Total: $prixTotal'),
                      Text('Date: ${timestamp.toDate()}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

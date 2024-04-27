import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_tickets/control/control_page.dart';


class HistoriqueTransactionsPage extends StatefulWidget {
  const HistoriqueTransactionsPage({Key? key}) : super(key: key);

  @override
  _HistoriqueTransactionsPageState createState() =>
      _HistoriqueTransactionsPageState();
}

class _HistoriqueTransactionsPageState
    extends State<HistoriqueTransactionsPage> {
  late String _userId;

  @override
  void initState() {
    super.initState();
    _userId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des transactions'),

        leading: IconButton(
        onPressed: () {

           Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ));

          },
        icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
      ),
        
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tickets')
            .where('user_id', isEqualTo: _userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erreur de chargement des données'));
          } else {
            final transactions = snapshot.data!.docs;
            if (transactions.isEmpty) {
              return const Center(child: Text('Aucune transaction trouvée.'));
            }
            return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  final nombreTicketsRepas = transaction['nombreTicketsRepas'];
                  final nombreTicketsPetitDej =
                      transaction['nombreTicketsPetitDej'];
                  final prixTotal = transaction['prix_total'];
                  final timestamp = transaction['timestamp'];

                  return Card(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Date: ${timestamp.toDate()}',style: const TextStyle(fontWeight: FontWeight.bold) ,),
                          
                          Text('$prixTotal FCFA'),
                        
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tickets Petit Déj: $nombreTicketsPetitDej'),
                          Text('Tickets Repas: $nombreTicketsRepas'),
                        ],
                      ),
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
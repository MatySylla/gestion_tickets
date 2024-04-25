import 'package:flutter/material.dart';
import 'package:gestion_tickets/provider/EtudiantModel.dart';
import 'package:gestion_tickets/widgets/historique/transaction.dart';
import 'package:gestion_tickets/widgets/menu/menu.dart';
import 'package:gestion_tickets/widgets/solde/achat.dart';
import 'package:gestion_tickets/widgets/solde/pageSolde.dart';
import 'package:provider/provider.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<EtudiantModel>(
          builder: (context, etudiantModel, child) {
            return Text(
              etudiantModel.etudiant != null
                  ? '${etudiantModel.etudiant!.nom} ${etudiantModel.etudiant!.prenom}'
                  : 'Chargement...',
              style: const TextStyle(fontSize: 20),
            );
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/AP.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 175, vertical: 150), // Ajustement du padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              _buildFeatureButton(Icons.event_note, 'Réserver', () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const MenuView(),
                ));
              }),
              _buildFeatureButton(Icons.shopping_cart, 'Acheter', () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const PageAchatTickets(),
                ));
              }),
              _buildFeatureButton(Icons.account_balance_wallet, 'Consulter', () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => PageSoldeTickets(),
                ));
              }),
              _buildFeatureButton(Icons.history, 'Historique', () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const HistoriqueTransactionsPage(),
                ));
              }),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureButton(IconData icon, String label, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
             
              Icon(icon, color:Colors.deepPurple ),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

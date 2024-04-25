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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/s1.jpg'), // Remplacez 'assets/background_image.jpg' par le chemin de votre image
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Accueil',
            style: TextStyle(),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Consumer<EtudiantModel>(
          builder: (context, etudiantModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  color: Colors.white.withOpacity(0.7), // Opacité ajoutée au fond blanc
                  child: etudiantModel.etudiant != null
                      ? Text(
                          'Bienvenue ${etudiantModel.etudiant!.nom} ${etudiantModel.etudiant!.prenom} !',
                          style: const TextStyle(
                            fontSize: 24.0,
                            color: Colors.deepPurple,
                          ),
                        )
                    : const Text(
                        'Chargement...',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.deepPurple,
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        leading: const Icon(Icons.event_note, color: Colors.deepPurple),
                        title: const Text('Réserver repas'),
                        onTap: () {
                                     Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => const MenuView(),
                                    ));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        leading: const Icon(Icons.shopping_cart, color: Colors.deepPurple),
                        title: const Text('Acheter des tickets'),
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                 builder: (context) => const PageAchatTickets(),
                              ));
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        leading: const Icon(Icons.account_balance_wallet, color: Colors.deepPurple),
                        title: const Text('Consulter le solde'),
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                 builder: (context) => PageSoldeTickets(),
                              ));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        leading: const Icon(Icons.history, color: Colors.deepPurple),
                        title: const Text('Voir historique'),
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                 builder: (context) => const HistoriqueTransactionsPage(),
                              ));
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  leading: const Icon(Icons.restaurant_menu,color: Colors.deepPurple),
                  title: const Text('Menu'),
                  onTap: () {
                     Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => const MenuView(),
                                    ));
                  },
                ),
              ),
              // Autres fonctionnalités ou sections de la page d'accueil
            ],
          );
        },
      ),
    )
    );
  }
}

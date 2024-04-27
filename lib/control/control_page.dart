import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_tickets/control/profil.dart';
import 'package:gestion_tickets/provider/EtudiantModel.dart';
import 'package:gestion_tickets/screens/accueil.dart';
import 'package:gestion_tickets/screens/home_page.dart';
import 'package:gestion_tickets/widgets/solde/achat.dart';
import 'package:gestion_tickets/widgets/menu/menu.dart';
import 'package:gestion_tickets/widgets/historique/transaction.dart';
import 'package:gestion_tickets/widgets/solde/pageSolde.dart';
import 'package:provider/provider.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const AccueilPage(),
    PageSoldeTickets(),
    const MenuView(),
    const  HistoriqueTransactionsPage (),
    const PageAchatTickets(),
  
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: const Text('E-CROUS', style:TextStyle(color: Colors.white) ),
        leading: IconButton(
          onPressed: () {
            // Action lorsque l'utilisateur appuie sur l'icône de menu
          },
          icon: const Icon(Icons.menu, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Action lorsque l'utilisateur appuie sur l'icône de recherche
            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              // Action lorsque l'utilisateur appuie sur l'icône de notification
            },
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
         PopupMenuButton<String>(
  onSelected: (String value) {
    // Logique pour chaque élément sélectionné dans le menu déroulant
    switch (value) {
      case 'Profil':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()), // Redirige vers la page de profil
        );
        break;
      case 'Paramètres':
        print('Paramètres utilisateur');
        break;
      case 'Déconnexion':
        // Déconnexion de l'utilisateur et retour à la page d'accueil
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
    }
  },
  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
    PopupMenuItem<String>(
      value: 'Profil',
      child: ListTile(
        leading: Icon(Icons.account_circle, color: Colors.deepPurple), // Icône Profil en mauve
        title: Consumer<EtudiantModel>(
          builder: (context, etudiantModel, child) {
            if (etudiantModel.etudiant != null) {
              // Utilisez les informations de l'utilisateur pour créer le texte du menu
              return Text('${etudiantModel.etudiant!.nom} ${etudiantModel.etudiant!.prenom}');
            } else {
              return Text('Profil');
            }
          },
        ),
      ),
    ),
    const PopupMenuItem<String>(
      value: 'Paramètres',
      child: ListTile(
        leading: Icon(Icons.settings, color: Colors.deepPurple), // Icône Paramètres en mauve
        title: Text('Paramètres'),
      )
    ),
    const PopupMenuItem<String>(
      value: 'Déconnexion',
      child: ListTile(
        leading: Icon(Icons.logout, color: Colors.deepPurple), // Icône Déconnexion en mauve
        title: Text('Déconnexion'),
      ),
    ),
  ],
  icon: const Icon(Icons.account_circle, color: Colors.white), // Icône en blanc
),
// Ajoutez d'autres éléments d'en-tête selon vos besoins     
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Solde',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menus',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historique',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.sell),
            label: 'Achat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
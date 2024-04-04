import 'package:flutter/material.dart';
import 'package:gestion_tickets/screens/EtudiantHome.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const EtudiantHomePage(),
    const BalanceView(),
    const MenuView(),
    const ReservationView(),
    const PaymentView(),
   
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
        title: const Text('Gestion des tickets'),
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
            icon: Icon(Icons.calendar_today),
            label: 'Réservation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Paiement',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class BalanceView extends StatelessWidget {
  const BalanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Solde de tickets : 10',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        ListTile(
          title: Text('Menu du jour 1'),
          subtitle: Text('Description du menu'),
          trailing: Text('Prix : \$5'),
        ),
        ListTile(
          title: Text('Menu du jour 2'),
          subtitle: Text('Description du menu'),
          trailing: Text('Prix : \$6'),
        ),
        // Ajoutez plus d'éléments de menu ici...
      ],
    );
  }
}

class ReservationView extends StatelessWidget {
  const ReservationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Logique pour réserver un repas
        },
        child: const Text('Réserver un repas'),
      ),
    );
  }
}

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Logique pour effectuer un paiement
        },
        child: const Text('Effectuer un paiement'),
      ),
    );
  }
}
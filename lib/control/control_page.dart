import 'package:flutter/material.dart';
import 'package:gestion_tickets/login/connexion.dart';
import 'package:gestion_tickets/screens/EtudiantHome.dart';

class ControlePage extends StatelessWidget {
  const ControlePage({super.key});


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(235, 225, 217, 217),
          title: const Text('gestion des tickets', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0, // Remove appbar shadow
        ),
        body:  const TabBarView(
          children: [
            // Replace with your TabBarView content
           
           EtudiantHomePage(),
            Center(child: Text('Page2')),
            Center(child: Text('Page3')),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(131, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home_outlined, size: 30),
                text: 'Accueil',
              ),
              Tab(
                icon: Icon(Icons.shopping_bag_outlined, size: 30),
                text: 'Tickets',
              ),
              Tab(
                icon: Icon(Icons.person_outline, size: 30),
                text: 'Compte',
              ),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}

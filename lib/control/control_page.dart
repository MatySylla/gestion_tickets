import 'package:flutter/material.dart';

class ControlePage extends StatelessWidget {
  const ControlePage({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Commandes', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0, // Remove appbar shadow
        ),
        body: const TabBarView(
          children: [
            // Replace with your TabBarView content
            Center(child: Text('Page1')),
            Center(child: Text('Page2')),
            Center(child: Text('Page3')),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
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

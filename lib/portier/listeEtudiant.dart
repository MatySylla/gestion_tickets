import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListeEtudiants extends StatelessWidget {
  const ListeEtudiants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Étudiants Inscrits'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('etudiant').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement des données'));
          } else {
            final etudiants = snapshot.data!.docs;
            if (etudiants.isEmpty) {
              return Center(child: Text('Aucun étudiant trouvé.'));
            }
            return ListView.builder(
              itemCount: etudiants.length,
              itemBuilder: (context, index) {
                final etudiant = etudiants[index];
                final nom = etudiant['nom'];
                final prenom = etudiant['prenom'];
                final email = etudiant['email'];

                return ListTile(
                  title: Text('$prenom $nom'),
                  subtitle: Text(email),
                );
              },
            );
          }
        },
      ),
    );
  }
}

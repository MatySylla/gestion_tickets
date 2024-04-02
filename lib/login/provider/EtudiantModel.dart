import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_tickets/model/Etudiant.dart';

class EtudiantModel extends ChangeNotifier {
  Etudiant? _etudiant;

  // Récupérer l'étudiant actuellement connecté
  Etudiant? get etudiant => _etudiant;

  // Mettre à jour l'étudiant actuellement connecté à partir de Firestore
  Future<void> fetchEtudiantDataFromFirestore(String userId) async {
    try {
      // Effectuer une requête à Firestore pour obtenir les données de l'utilisateur
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('etudiant')
          .doc(userId)
          .get();

      // Vérifier si le document existe
      if (documentSnapshot.exists) {
        // Convertir les données Firestore en un objet Etudiant en utilisant la méthode fromJson
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        Etudiant etudiant = Etudiant.fromJson(data);

        // Mettre à jour l'étudiant dans le modèle
        _etudiant = etudiant;
        notifyListeners(); // Notifie les écouteurs du changement
      } else {
        // Le document n'existe pas, vous pouvez gérer cette situation comme nécessaire
        print('Aucun document trouvé pour l\'utilisateur avec l\'ID $userId');
      }
    } catch (error) {
      // Gérer les erreurs de récupération des données depuis Firestore
      print(
          'Erreur lors de la récupération des données de l\'utilisateur : $error');
    }
  }
}

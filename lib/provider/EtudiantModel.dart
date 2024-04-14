import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<num?> fetchSoldeTicketsRepasFromFirestore(String userId) async {
    try {
      // Effectuer une requête à Firestore pour obtenir les tickets repas de l'utilisateur
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('tickets')
          .where('user_id', isEqualTo: userId)
          .get();

      // Calculer le total des tickets repas de l'utilisateur
      num totalTicketsRepas = 0;
      querySnapshot.docs.forEach((doc) {
        totalTicketsRepas += doc['nombreTicketsRepas'] ?? 0;
      });

      return totalTicketsRepas;
    } catch (error) {
      // Gérer les erreurs de récupération des données depuis Firestore
      print(
          'Erreur lors de la récupération du solde des tickets repas : $error');
      return null;
    }
  }

  Future<num?> fetchSoldeTicketsPetitDejFromFirestore(String userId) async {
    try {
      // Effectuer une requête à Firestore pour obtenir les tickets petit déjeuner de l'utilisateur
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('tickets')
          .where('user_id', isEqualTo: userId)
          .get();

      // Calculer le total des tickets petit déjeuner de l'utilisateur
      num totalTicketsPetitDej = 0;
      querySnapshot.docs.forEach((doc) {
        totalTicketsPetitDej += (doc['nombreTicketsPetitDej'] ?? 0);
      });

      return totalTicketsPetitDej;
    } catch (error) {
      // Gérer les erreurs de récupération des données depuis Firestore
      print(
          'Erreur lors de la récupération du solde des tickets petit déjeuner : $error');
      return null;
    }
  }
   Future<void> debiterTickets({
    required String idEtudiant,
    required int nombreTicketsRepas,
    required int nombreTicketsPetitDej,
  }) async {
    try {
      // Récupérer l'utilisateur actuellement connecté
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("Utilisateur non connecté");
      }

      // Récupérer les informations de l'étudiant depuis Firestore
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('etudiant')
          .doc(idEtudiant)
          .get();

      if (documentSnapshot.exists) {
        // Convertir les données Firestore en un objet Etudiant
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        int? ticketsRepas = data['nombreTicketsRepas'];
        int? ticketsPetitDej = data['nombreTicketsPetitDej'];

        // Vérifier si l'étudiant a suffisamment de tickets
        if (ticketsRepas != null &&
            ticketsPetitDej != null &&
            ticketsRepas >= nombreTicketsRepas &&
            ticketsPetitDej >= nombreTicketsPetitDej) {
          // Calculer le nouveau solde de tickets
          int nouveauTicketsRepas = ticketsRepas - nombreTicketsRepas;
          int nouveauTicketsPetitDej = ticketsPetitDej - nombreTicketsPetitDej;

          // Mettre à jour les informations de l'étudiant dans Firestore
          await FirebaseFirestore.instance.collection('etudiant').doc(idEtudiant).update({
            'nombreTicketsRepas': nouveauTicketsRepas,
            'nombreTicketsPetitDej': nouveauTicketsPetitDej,
          });

          // Notifier les écouteurs du changement
          notifyListeners();
        } else {
          throw Exception("L'étudiant n'a pas suffisamment de tickets");
        }
      } else {
        throw Exception("L'étudiant n'existe pas dans la base de données");
      }
    } catch (error) {
      // Gérer les erreurs
      print("Erreur lors du débit des tickets : $error");
    }
  }
}

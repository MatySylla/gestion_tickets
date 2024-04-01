import 'package:flutter/material.dart';
import 'package:gestion_tickets/model/Etudiant.dart';

class EtudiantModel extends ChangeNotifier {
  Etudiant? _etudiant;

  // Récupérer l'étudiant actuellement connecté
  Etudiant? get etudiant => _etudiant;

  // Mettre à jour l'étudiant actuellement connecté
  void updateEtudiant(Etudiant newEtudiant) {
    _etudiant = newEtudiant;
    notifyListeners(); // Notifie les écouteurs du changement
  }
}

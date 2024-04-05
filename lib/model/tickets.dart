class Ticket {
  final String id;
  final String userId;
  final DateTime dateAchat; // Date d'achat automatiquement générée
  final double montant; // Montant du ticket
  final TypeTicket type; // Type de ticket

  Ticket({
    required this.id,
    required this.userId,
    required DateTime dateAchat,
    required this.montant,
    required this.type,
  }) : dateAchat = DateTime.now(); // Initialisation avec la date et l'heure actuelles
}

// Enumération pour les types de tickets
enum TypeTicket {
  repas,
  petitDejeuner,
}
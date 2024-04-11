class Ticket {
  final String id;
  final String userId;
  final DateTime dateAchat;
  final int nombreTicketsPetitDej;
  final int nombreTicketsRepas;
  final TypeTicket type;

  Ticket({
    required this.id,
    required this.userId,
    required DateTime dateAchat,
    required this.nombreTicketsRepas,
    required this.nombreTicketsPetitDej,
    required this.type,
  }): dateAchat =
     DateTime.now();

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      dateAchat: DateTime.parse(json['dateAchat'] ?? ''), // Convertir en DateTime
      nombreTicketsRepas: json['nombre_tickets_repas'] ?? 0,
      nombreTicketsPetitDej: json['nombre_tickets_petit_dej'] ?? 0,
      type: _getTypeFromJson(json['type'] ?? ''),
    );
  }

  static TypeTicket _getTypeFromJson(String type) {
    switch (type) {
      case 'repas':
        return TypeTicket.repas;
      case 'petitDejeuner':
        return TypeTicket.petitDejeuner;
      default:
        return TypeTicket.repas;
    }
  }
}

// Enumération pour les types de tickets
enum TypeTicket {
  repas,
  petitDejeuner,
}